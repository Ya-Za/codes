/**
 * Tree
 */

import NodeTree from "./NodeTree"

export default class Tree {
    root: NodeTree;

    constructor() {
    }

    /**
     * Check equality of two input trees.
     * @param t1 First tree.
     * @param t2 Second tree.
     */
    static equals(t1: Tree, t2: Tree): boolean {
        let res = true;
        function recursive(node1: NodeTree, node2: NodeTree) {
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
    equals(t2: Tree): boolean {
        return Tree.equals(this, t2);
    }

    /**
     * Create `Tree` object from parentheses formated string.
     * @param str Input parentheses formated string.
     */
    static fromString(str: string) {
        let stack = [];
        let nameArray = [];

        let seperators = ['(', ')', ',']
        for (let char of str) {
            if (seperators.indexOf(char) != -1) {
                let name = nameArray.join('').trim();
                if (name != "") {
                    stack.push(new NodeTree(name))
                }

                nameArray = [];

                if (char == '(') {
                    stack.push(char);
                } else if (char == ')') {
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
            } else {
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

            strArray.push('(')

            let childs = node.childs;
            let numberOfChilds = childs.length;

            for (let indexOfChild = 0; indexOfChild < numberOfChilds; indexOfChild++) {
                let child = childs[indexOfChild];
                recursive(child);

                if (indexOfChild < numberOfChilds - 1) {
                    strArray.push(',')
                }
            }

            strArray.push(')')
        }

        recursive(this.root);
        return strArray.join('');
    }

    /**
     * Create `Tree` object from `json` string.
     * @param str Input `json` string.
     */
    static fromJson(js: object) {
        function recursive(jsnode, name, parent) {
            let node = new NodeTree(name, parent);

            if (jsnode !== null) {
                for (let key in jsnode) {
                    node.childs.push(recursive(jsnode[key], key, node))
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
                    recursive(child, jsnode[node.name])
                }
            } else {
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
        function makeSpaceStr(numberOfSpaces: number): string {
            let res = [];
            for (let i = 0; i < numberOfSpaces; i++) {
                res.push(' ');
            }

            return res.join('');
        }

        function recursive(node, prefix: string, isLastChild: boolean, isRoot: boolean = false) {
            str.push(prefix);
            if (!isRoot) {
                str.push("--");
            }
            str.push(node.name + '\n');

            if (isLastChild) {
                prefix = makeSpaceStr(prefix.length)
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
                    } else {
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
    static add(parent: NodeTree, child: NodeTree) {
        child.parent = parent;
        parent.childs.push(child);
    }

    static delete(node: NodeTree) {
        let parent = node.parent;
        if (parent === null) {
            return;
        }

        let index = parent.childs.indexOf(node);
        parent.childs.splice(index, 1)
    }

    /**
     * Depth first search
     * @param root Input node
     */
    static *dfs(root: NodeTree) {
        yield root;

        for (let child of root.childs) {
            yield* Tree.dfs(child);
        }
    }

    /**
     * Breadth first search
     * @param root Input root
     */
    static *bfs(root: NodeTree) {
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
    static *ancestors(node: NodeTree) {
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
    static *descendants(root: NodeTree) {
        let gen = Tree.bfs(root);
        gen.next();
        yield* gen;
    }
}