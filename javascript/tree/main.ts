import Tree from "./Tree";
import NodeTree from "./NodeTree"

main();

function main() {
    let js = {
        "key": "a",
        "childs": [
            {
                "key": "b",
                "childs": null
            },
            {
                "key": "c",
                "childs": [
                    {
                        "key": "e",
                        "childs": null
                    },
                    {
                        "key": "f",
                        "childs": null
                    }
                ]
            },
            {
                "key": "d",
                "childs": null
            }
        ]
    };

    let jsS = {
        "a": {
            "b": {
                "b1": null,
                "b2": null
            },
            "c": null,
            "d": {
                "e": null,
                "f": null
            }
        }
    };

    let pa = "a(b,c(e,f),d(g, h))";

    // js = parantheses2json(pa);
    // console.log(json2parentheses(js));


    // let x = json2short(js);
    // let x = short2json(jsS);
    // console.log(json2str(x));

    // Arrange
    let tree = Tree.fromString("a(b,c)");
    let expected = {
        "a": {
            "b": null,
            "c": null
        }
    };

    // Act
    let actual = tree.toJson();
}

function parantheses2json(pa) {
    let stack = [];
    let key = [];

    let seperators = ['(', ')', ',']
    for (let char of pa) {
        if (seperators.indexOf(char) != -1) {
            let keyStr = key.join('').trim();
            if (keyStr != "") {
                stack.push(
                    {
                        "key": keyStr,
                        "childs": null
                    }
                );
            }

            key = [];

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
            key.push(char);
        }
    }

    return stack.pop();
}

function json2parentheses(js) {
    let pa = [];

    function recursive(root) {
        if (root == null) {
            return
        }

        pa.push(root.key);

        if (root.childs == null) {
            return;
        }

        pa.push('(')

        let childs = root.childs;
        let numberOfChilds = childs.length;

        for (let indexOfChild = 0; indexOfChild < numberOfChilds; indexOfChild++) {
            let child = childs[indexOfChild];
            recursive(child);

            if (indexOfChild < numberOfChilds - 1) {
                pa.push(',')
            }
        }

        pa.push(')')
    }

    recursive(js);
    return pa.join('');
}

function json2str(js) {
    let str = [];

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
        str.push(node.key + '\n');

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

    recursive(js, '', false, true);

    return str.join('');
}

function json2short(js) {
    function recursive(node, res) {
        res[node.key] = {};

        if (node.childs != null) {
            res = res[node.key];

            for (let child of node.childs) {
                recursive(child, res)
            }
        } else {
            res[node.key] = null;
        }
    }

    let root = {};
    recursive(js, root);

    return root;
}

function short2json(short) {
    function recursive(node, key) {
        let childs;

        if (node == null) {
            childs = null;
        } else {
            childs = [];
            for (let item in node) {
                childs.push(recursive(node[item], item))
            }
        }

        return {
            "key": key,
            "childs": childs
        }
    }

    return recursive(short, "root").childs[0];
}

function jsonShort2parentheses(js) {
    let pa = [];

    function recursive(root) {
        if (root == null) {
            return
        }

        pa.push('(')

        let childs = Object.getOwnPropertyNames(root);
        let numberOfChilds = childs.length;

        for (let indexOfChild = 0; indexOfChild < numberOfChilds; indexOfChild++) {
            let child = childs[indexOfChild];
            pa.push(child);
            recursive(root[child]);

            if (indexOfChild < numberOfChilds - 1) {
                pa.push(',')
            }
        }

        pa.push(')')
    }

    recursive(js);
    return pa.join('');
}