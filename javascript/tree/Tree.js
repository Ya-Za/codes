/**
 * Tree
 */
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var NodeTree_1 = require("./NodeTree");
var Tree = (function () {
    function Tree() {
    }
    /**
     * Check equality of two input trees.
     * @param t1 First tree.
     * @param t2 Second tree.
     */
    Tree.equals = function (t1, t2) {
        var res = true;
        function recursive(node1, node2) {
            // check names
            if (node1.name != node2.name) {
                res = false;
                return;
            }
            // check childs
            if (node1.childs.length != node2.childs.length) {
                res = false;
                return;
            }
            var length = node1.childs.length;
            for (var i = 0; i < length; i++) {
                var child1 = node1.childs[i];
                var child2 = node2.childs[i];
                // check parents
                if (child1.parent != node1 ||
                    child2.parent != node2) {
                    res = false;
                    return;
                }
                recursive(child1, child2);
                if (!res) {
                    return;
                }
            }
        }
        recursive(t1.root, t2.root);
        return res;
    };
    /**
     * Check equality with another tree.
     * @param t2 Second tree.
     */
    Tree.prototype.equals = function (t2) {
        return Tree.equals(this, t2);
    };
    /**
     * Create `Tree` object from parentheses formated string.
     * @param str Input parentheses formated string.
     */
    Tree.fromString = function (str) {
        var stack = [];
        var nameArray = [];
        var seperators = ['(', ')', ','];
        for (var _i = 0, str_1 = str; _i < str_1.length; _i++) {
            var char = str_1[_i];
            if (seperators.indexOf(char) != -1) {
                var name_1 = nameArray.join('').trim();
                if (name_1 != "") {
                    stack.push(new NodeTree_1.default(name_1));
                }
                nameArray = [];
                if (char == '(') {
                    stack.push(char);
                }
                else if (char == ')') {
                    var childs = [];
                    var item = void 0;
                    item = stack.pop();
                    while (item != '(') {
                        childs.push(item);
                        item = stack.pop();
                    }
                    var parent_1 = stack[stack.length - 1];
                    parent_1.childs = childs.reverse();
                    for (var _a = 0, childs_1 = childs; _a < childs_1.length; _a++) {
                        var child = childs_1[_a];
                        child.parent = parent_1;
                    }
                }
            }
            else {
                nameArray.push(char);
            }
        }
        var tree = new Tree();
        tree.root = stack.pop();
        return tree;
    };
    /**
     * Convert to string.
     */
    Tree.prototype.toString = function () {
        var strArray = [];
        function recursive(node) {
            if (node == null) {
                return;
            }
            strArray.push(node.name);
            if (node.childs.length == 0) {
                return;
            }
            strArray.push('(');
            var childs = node.childs;
            var numberOfChilds = childs.length;
            for (var indexOfChild = 0; indexOfChild < numberOfChilds; indexOfChild++) {
                var child = childs[indexOfChild];
                recursive(child);
                if (indexOfChild < numberOfChilds - 1) {
                    strArray.push(',');
                }
            }
            strArray.push(')');
        }
        recursive(this.root);
        return strArray.join('');
    };
    /**
     * Create `Tree` object from `json` string.
     * @param str Input `json` string.
     */
    Tree.fromJson = function (js) {
        function recursive(jsnode, name, parent) {
            var node = new NodeTree_1.default(name, parent);
            if (jsnode !== null) {
                for (var key in jsnode) {
                    node.childs.push(recursive(jsnode[key], key, node));
                }
            }
            return node;
        }
        var tree = new Tree();
        if (js !== null && Object.keys(js).length != 0) {
            var rootName = Object.keys(js)[0];
            tree.root = recursive(js[rootName], rootName, null);
        }
        return tree;
    };
    /**
     * Convert to `json` object.
     */
    Tree.prototype.toJson = function () {
        // todo: convert to `iife` with arrow functions
        function recursive(node, jsnode) {
            jsnode[node.name] = {};
            if (node.childs.length != 0) {
                for (var _i = 0, _a = node.childs; _i < _a.length; _i++) {
                    var child = _a[_i];
                    recursive(child, jsnode[node.name]);
                }
            }
            else {
                jsnode[node.name] = null;
            }
        }
        var js = {};
        recursive(this.root, js);
        return js;
    };
    return Tree;
}());
exports.default = Tree;
//# sourceMappingURL=Tree.js.map