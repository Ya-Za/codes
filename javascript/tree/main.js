main();
function main() {
    var js = {
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
    var jsS = {
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
    var pa = "a(b,c(e,f),d(g, h))";
    // js = parantheses2json(pa);
    // console.log(json2parentheses(js));
    // let x = json2short(js);
    var x = short2json(jsS);
    console.log(json2str(x));
}
function parantheses2json(pa) {
    var stack = [];
    var key = [];
    var seperators = ['(', ')', ','];
    for (var _i = 0, pa_1 = pa; _i < pa_1.length; _i++) {
        var char = pa_1[_i];
        if (seperators.indexOf(char) != -1) {
            var keyStr = key.join('').trim();
            if (keyStr != "") {
                stack.push({
                    "key": keyStr,
                    "childs": null
                });
            }
            key = [];
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
            key.push(char);
        }
    }
    return stack.pop();
}
function json2parentheses(js) {
    var pa = [];
    function recursive(root) {
        if (root == null) {
            return;
        }
        pa.push(root.key);
        if (root.childs == null) {
            return;
        }
        pa.push('(');
        var childs = root.childs;
        var numberOfChilds = childs.length;
        for (var indexOfChild = 0; indexOfChild < numberOfChilds; indexOfChild++) {
            var child = childs[indexOfChild];
            recursive(child);
            if (indexOfChild < numberOfChilds - 1) {
                pa.push(',');
            }
        }
        pa.push(')');
    }
    recursive(js);
    return pa.join('');
}
// function json2str(js) {
//     let str = [];
//     // todo: remove `dashLine` method and add a `dashLine` parameter that a path from root downward
//     function addLine(depth, isLastChild) {
//         if (depth == 0) {
//             return;
//         }
//         for (let i = 0; i < depth - 1; i++) {
//             str.push('|  ');
//         }
//         if (isLastChild) {
//             str.push('`');
//         } else {
//             str.push('|');
//         }
//         str.push('--')
//     }
//     function recursive(node, depth, isLastChild) {
//         addLine(depth, isLastChild);
//         str.push(node.key + '\n');
//         if (node.childs != null) {
//             let numberOfChilds = node.childs.length;
//             for (let indexOfChild = 0; indexOfChild < numberOfChilds; indexOfChild++) {
//                 let child = node.childs[indexOfChild];
//                 if (indexOfChild == numberOfChilds - 1) {
//                     recursive(child, depth + 1, true);
//                 } else {
//                     recursive(child, depth + 1, false);
//                 }
//             }
//         }
//     }
//     recursive(js, 0, false);
//     return str.join('');
// }
function json2str(js) {
    var str = [];
    function makeSpaceStr(numberOfSpaces) {
        var res = [];
        for (var i = 0; i < numberOfSpaces; i++) {
            res.push(' ');
        }
        return res.join('');
    }
    function recursive(node, prefix, isLastChild, isRoot) {
        if (isRoot === void 0) { isRoot = false; }
        str.push(prefix);
        if (!isRoot) {
            str.push("--");
        }
        str.push(node.key + '\n');
        if (isLastChild) {
            prefix = makeSpaceStr(prefix.length);
        }
        if (!isRoot) {
            prefix += '  ';
        }
        if (node.childs != null) {
            var numberOfChilds = node.childs.length;
            for (var indexOfChild = 0; indexOfChild < numberOfChilds; indexOfChild++) {
                var child = node.childs[indexOfChild];
                if (indexOfChild == numberOfChilds - 1) {
                    recursive(child, prefix + '`', true);
                }
                else {
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
            for (var _i = 0, _a = node.childs; _i < _a.length; _i++) {
                var child = _a[_i];
                recursive(child, res);
            }
        }
        else {
            res[node.key] = null;
        }
    }
    var root = {};
    recursive(js, root);
    return root;
}
function short2json(short) {
    function recursive(node, key) {
        var childs;
        if (node == null) {
            childs = null;
        }
        else {
            childs = [];
            for (var item in node) {
                childs.push(recursive(node[item], item));
            }
        }
        return {
            "key": key,
            "childs": childs
        };
    }
    return recursive(short, "root").childs[0];
}
function jsonShort2parentheses(js) {
    var pa = [];
    function recursive(root) {
        if (root == null) {
            return;
        }
        pa.push('(');
        var childs = Object.getOwnPropertyNames(root);
        var numberOfChilds = childs.length;
        for (var indexOfChild = 0; indexOfChild < numberOfChilds; indexOfChild++) {
            var child = childs[indexOfChild];
            pa.push(child);
            recursive(root[child]);
            if (indexOfChild < numberOfChilds - 1) {
                pa.push(',');
            }
        }
        pa.push(')');
    }
    recursive(js);
    return pa.join('');
}
//# sourceMappingURL=main.js.map