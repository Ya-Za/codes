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
            "b": null,
            "c": {
                "e": null,
                "f": null
            },
            "d": null
        }
    };

    let pa = "a(b,c(e,f),d)";

    // console.log(json2parentheses(js));
    js = parantheses2json(pa);
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

function parantheses2json(pa) {
    let stack = [];
    let key = [];

    for (let char of pa) {
        if (char == '(') {
            stack.push(
                {
                    "key": key.join('').trim(),
                    "childs": null
                }
            );

            stack.push(char);

            key = [];
        } else if (char == ')') {
            stack.push(
                {
                    "key": key.join('').trim(),
                    "childs": null
                }
            );

            key = [];
            
            let list = [];
            let item;

            item = stack.pop();
            while (item != '(') {
                list.push(item);
                item = stack.pop();
            }

            stack[stack.length - 1].childs = list;

        } else if (char == ',') {
            stack.push(
                {
                    "key": key.join('').trim(),
                    "childs": null
                }
            );

            key = [];
        } else {
            key.push(char);
        }
    }

    return stack.pop();
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