// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require('jstree');

require('../../../node_modules/jstree/dist/themes/default/style.min.css');

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

global.$ = require('jquery');

function createTree($el, source_url) {
    console.log(source_url);
    $.ajax({
        url: source_url,
        dataType: 'JSON'
    }).done((data) => {
        $el.jstree({
            'core' : {
                worker: false,
                animation: false,
                multiple: false,
                data: data,
                check_callback: true,
                themes: {
                    icons: false
                }
            },
            plugins: ["sort"],
            'sort' : function (a, b) { return (parseInt(a) < parseInt(b)) ? -1 : 1; }
        });

        console.log('Таблица создана: ', $el.attr('id'), data);
    });
}

$(() => {
    //добавляем токен ко всем ajax-запросам
    $.ajaxSetup({
        headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
    });

    let $database_tree_el = $('#database-tree-view'),
        database_tree_url = $database_tree_el.attr('data-db-nodes-url'),
        $cache_tree_el = $('#cache-tree-view'),
        cache_tree_url = $cache_tree_el.attr('data-cache-nodes-url'),
        cache_node_create_url = $cache_tree_el.attr('data-cache-node-create-url');


    createTree($database_tree_el, database_tree_url);
    createTree($cache_tree_el, cache_tree_url);

    $('#apply-changes').click(function () {
        let apply_url = $(this).attr('data-apply-url');

        $.ajax({
            url: apply_url,
            dataType: 'JSON',
            method: 'POST',
        }).done(() => {
            location.reload()
        });
    });

    $('#delete-node').click(function () {
        let delete_url = $(this).attr('data-delete-node-url'),
            $js_tree = $cache_tree_el.jstree(),
            node_id = $js_tree.get_selected();

        if (node_id.length === 0) {
            alert('Нужно выбрать элемент для удаления');
            return
        }

        let node = $js_tree.get_json(node_id, {no_children: true});

        $.ajax({
            url: delete_url + '/' + node.id,
            dataType: 'JSON',
            method: 'DELETE',
        }).done((data) => {
            $js_tree.settings.core.data = data
            $js_tree.refresh()
        });
    });

    $('#edit-node').click(function () {
        let edit_url = $(this).attr('data-edit-url'),
            $js_tree = $cache_tree_el.jstree(),
            node_id = $js_tree.get_selected();

        if (node_id.length === 0) {
            alert('Выберите элемент для редактирования')
        }

        let node = $js_tree.get_json(node_id, {no_children: true});

        $js_tree.edit(node, node.text, ((node, is_edited, is_canceled, text) => {
            if (is_edited && !is_canceled) {
                $.ajax({
                    url: edit_url + '/' + node.id,
                    dataType: 'JSON',
                    method: 'PATCH',
                    data: {
                        value: text
                    }
                })
            }
        }));
    });

    $('#add-node').click(function () {
        let new_node_url = $(this).attr('data-add-node-url'),
            node_id = $cache_tree_el.jstree().get_selected(),
            $js_tree = $cache_tree_el.jstree();

        if (node_id.length === 0) {
            alert('Нужно выбрать элемент для добавления потомка');
            return
        }

        let node = $js_tree.get_json(node_id, {no_children: true}),
            new_node_id = $js_tree.create_node(node);

        $js_tree.edit(new_node_id, 'New Node', ((new_node) => {
            console.log(new_node.parent);
            $.ajax({
                url: new_node_url,
                dataType: 'JSON',
                method: 'POST',
                data: {
                    value: new_node.text,
                    parent_id: new_node.parent
                }
            }).done((data) => {
                $js_tree.settings.core.data = data
                $js_tree.refresh()
            });
        }));
    });

    $('#reset-trees').click(function () {
        let reset_url = $(this).attr('data-reset-url');

        $.ajax({
            url: reset_url,
            dataType: 'JSON',
            method: 'POST'
        }).done(() => {
            location.reload()
        });
    });

    $('#add-to-cache').click(function () {
        let node_id = $database_tree_el.jstree().get_selected(),
            node;

        if (node_id.length === 0) {
            alert('Нужно выбрать элемент для добавления в кэш');
            return
        }

        node = $database_tree_el.jstree().get_json(node_id, {no_children: true});

        $.ajax({
            url: cache_node_create_url,
            dataType: 'JSON',
            method: 'POST',
            data: {
                id: node.id,
                value: node.text,
                parent_id: $database_tree_el.jstree().get_parent(node_id),
                origin_id: node.id
            }
        }).done((data) => {
            $cache_tree_el.jstree().settings.core.data = data
            $cache_tree_el.jstree().refresh()
        });
    });
});