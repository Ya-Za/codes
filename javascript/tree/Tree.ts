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
        function recursive(
            parent1: NodeTree, node1: NodeTree,
            parent2: NodeTree, node2: NodeTree) {
            // check parents
            if (node1.parent != parent1 ||
                node2.parent != parent2) {
                res = false;
                return;
            }

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
                recursive(node1, node1.childs[i], node2, node2.childs[i]);
                if (!res) {
                    return;
                }
            }
        }

        recursive(null, t1.root, null, t2.root);

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
    static fromStr(str: string) {
        let stack = [];
        let name = [];

        let seperators = ['(', ')', ',']
        for (let char of str) {
            if (seperators.indexOf(char) != -1) {
                let nameStr = name.join('').trim();
                if (nameStr != "") {
                    stack.push(
                        {
                            "name": nameStr,
                            "childs": null
                        }
                    );
                }

                name = [];

                if (char == '(') {
                    stack.push(char);
                } else if (char == ')') {
                    let list = [];
                    let item;

                    item = stack.pop();
                    while (item != '(') {
                        list.push(item);
                        item = stack.pop();
                    }

                    stack[stack.length - 1].childs = list.reverse();
                }
            } else {
                name.push(char);
            }
        }

        return stack.pop();
    }
}