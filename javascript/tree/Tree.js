"use strict";
/**
 * Tree
 */
Object.defineProperty(exports, "__esModule", { value: true });
const NodeTree_1 = require("./NodeTree");
class Tree {
    constructor() {
    }
    /**
     * Check equality of two input trees.
     * @param t1 First tree.
     * @param t2 Second tree.
     */
    static equals(t1, t2) {
        let res = true;
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
            let length = node1.childs.length;
            for (let i = 0; i < length; i++) {
                let child1 = node1.childs[i];
                let child2 = node2.childs[i];
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
    }
    /**
     * Check equality with another tree.
     * @param t2 Second tree.
     */
    equals(t2) {
        return Tree.equals(this, t2);
    }
    /**
     * Create `Tree` object from parentheses formated string.
     * @param str Input parentheses formated string.
     */
    static fromString(str) {
        let stack = [];
        let nameArray = [];
        let seperators = ['(', ')', ','];
        for (let char of str) {
            if (seperators.indexOf(char) != -1) {
                let name = nameArray.join('').trim();
                if (name != "") {
                    stack.push(new NodeTree_1.default(name));
                }
                nameArray = [];
                if (char == '(') {
                    stack.push(char);
                }
                else if (char == ')') {
                    let childs = [];
                    let item;
                    item = stack.pop();
                    while (item != '(') {
                        childs.push(item);
                        item = stack.pop();
                    }
                    let parent = stack[stack.length - 1];
                    parent.childs = childs.reverse();
                    for (let child of childs) {
                        child.parent = parent;
                    }
                }
            }
            else {
                nameArray.push(char);
            }
        }
        let tree = new Tree();
        tree.root = stack.pop();
        return tree;
    }
    /**
     * Convert to string.
     */
    toString() {
        let strArray = [];
        function recursive(node) {
            if (node == null) {
                return;
            }
            strArray.push(node.name);
            if (node.childs.length == 0) {
                return;
            }
            strArray.push('(');
            let childs = node.childs;
            let numberOfChilds = childs.length;
            for (let indexOfChild = 0; indexOfChild < numberOfChilds; indexOfChild++) {
                let child = childs[indexOfChild];
                recursive(child);
                if (indexOfChild < numberOfChilds - 1) {
                    strArray.push(',');
                }
            }
            strArray.push(')');
        }
        recursive(this.root);
        return strArray.join('');
    }
    /**
     * Create `Tree` object from `json` string.
     * @param str Input `json` string.
     */
    static fromJson(js) {
        function recursive(jsnode, name, parent) {
            let node = new NodeTree_1.default(name, parent);
            if (jsnode !== null) {
                for (let key in jsnode) {
                    node.childs.push(recursive(jsnode[key], key, node));
                }
            }
            return node;
        }
        let tree = new Tree();
        if (js !== null && Object.keys(js).length != 0) {
            let rootName = Object.keys(js)[0];
            tree.root = recursive(js[rootName], rootName, null);
        }
        return tree;
    }
    /**
     * Convert to `json` object.
     */
    toJson() {
        // todo: convert to `iife` with arrow functions
        function recursive(node, jsnode) {
            jsnode[node.name] = {};
            if (node.childs.length != 0) {
                for (let child of node.childs) {
                    recursive(child, jsnode[node.name]);
                }
            }
            else {
                jsnode[node.name] = null;
            }
        }
        let js = {};
        recursive(this.root, js);
        return js;
    }
    /**
     * Get pretty formatted string
     */
    pretty() {
        // output pretty formatted string
        let str = [];
        /**
         * Make a specified length space string
         * @param numberOfSpaces Length of output string
         */
        function makeSpaceStr(numberOfSpaces) {
            let res = [];
            for (let i = 0; i < numberOfSpaces; i++) {
                res.push(' ');
            }
            return res.join('');
        }
        function recursive(node, prefix, isLastChild, isRoot = false) {
            str.push(prefix);
            if (!isRoot) {
                str.push("--");
            }
            str.push(node.name + '\n');
            if (isLastChild) {
                prefix = makeSpaceStr(prefix.length);
            }
            if (!isRoot) {
                prefix += '  ';
            }
            if (node.childs != null) {
                let numberOfChilds = node.childs.length;
                for (let indexOfChild = 0; indexOfChild < numberOfChilds; indexOfChild++) {
                    let child = node.childs[indexOfChild];
                    if (indexOfChild == numberOfChilds - 1) {
                        recursive(child, prefix + '`', true);
                    }
                    else {
                        recursive(child, prefix + '|', false);
                    }
                }
            }
        }
        recursive(this.root, '', false, true);
        return str.join('');
    }
    /**
     * Add child to specified parent
     * @param parent Target parent
     * @param child Input child
     */
    static add(parent, child) {
        child.parent = parent;
        parent.childs.push(child);
    }
    static delete(node) {
        let parent = node.parent;
        if (parent === null) {
            return;
        }
        let index = parent.childs.indexOf(node);
        parent.childs.splice(index, 1);
    }
    /**
     * Depth first search
     * @param root Input node
     */
    static *dfs(root) {
        yield root;
        for (let child of root.childs) {
            yield* Tree.dfs(child);
        }
    }
    /**
     * Breadth first search
     * @param root Input root
     */
    static *bfs(root) {
        let queue = [root];
        while (queue.length > 0) {
            let node = queue.shift();
            yield node;
            for (let child of node.childs) {
                queue.push(child);
            }
        }
    }
    /**
     * Get ancestors
     * @param node Input node
     */
    static *ancestors(node) {
        let parent = node.parent;
        while (parent !== null) {
            yield parent;
            parent = parent.parent;
        }
    }
    /**
     * Get descendants
     * @param root Input root
     */
    static *descendants(root) {
        let gen = Tree.bfs(root);
        gen.next();
        yield* gen;
    }
    /**
     * Get self
     * @param node Input node
     */
    static self(node) {
        return node;
    }
    /**
     * Get parent
     * @param node Input node
     */
    static parent(node) {
        return node.parent;
    }
    /**
     * Get childs
     * @param node Input node
     */
    static *childs(node) {
        for (let child of node.childs) {
            yield child;
        }
    }
    /**
     * Get previous siblings
     * @param node Input node
     */
    static *previousSiblings(node) {
        let parent = node.parent;
        if (parent === null) {
            return;
        }
        let childs = parent.childs;
        let index = childs.indexOf(node);
        if (index === -1) {
            return;
        }
        for (let i = 0; i < index; i++) {
            yield childs[i];
        }
    }
    /**
     * Get next siblings
     * @param node Input node
     */
    static *nextSiblings(node) {
        let parent = node.parent;
        if (parent === null) {
            return;
        }
        let childs = parent.childs;
        let index = childs.indexOf(node);
        if (index === -1) {
            return;
        }
        let length = childs.length;
        for (let i = index + 1; i < length; i++) {
            yield childs[i];
        }
    }
    /**
     * Get siblings
     * @param node Input node
     */
    static *siblings(node) {
        yield* Tree.previousSiblings(node);
        yield* Tree.nextSiblings(node);
    }
}
exports.default = Tree;
//# sourceMappingURL=Tree.js.map