"use strict";
/**
 * Tree
 */
Object.defineProperty(exports, "__esModule", { value: true });
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
    Tree.fromStr = function (str) {
        var stack = [];
        var name = [];
        var seperators = ['(', ')', ','];
        for (var _i = 0, str_1 = str; _i < str_1.length; _i++) {
            var char = str_1[_i];
            if (seperators.indexOf(char) != -1) {
                var nameStr = name.join('').trim();
                if (nameStr != "") {
                    stack.push({
                        "name": nameStr,
                        "childs": null
                    });
                }
                name = [];
                if (char == '(') {
                    stack.push(char);
                }
                else if (char == ')') {
                    var list = [];
                    var item = void 0;
                    item = stack.pop();
                    while (item != '(') {
                        list.push(item);
                        item = stack.pop();
                    }
                    stack[stack.length - 1].childs = list.reverse();
                }
            }
            else {
                name.push(char);
            }
        }
        return stack.pop();
    };
    return Tree;
}());
exports.default = Tree;
//# sourceMappingURL=Tree.js.map