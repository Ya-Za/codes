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
            "b": null,
            "c": {
                "e": null,
                "f": null
            },
            "d": null
        }
    };
    var pa = "a(b,c(e,f),d)";
    // console.log(json2parentheses(js));
    js = parantheses2json(pa);
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
function parantheses2json(pa) {
    var stack = [];
    var key = [];
    for (var _i = 0, pa_1 = pa; _i < pa_1.length; _i++) {
        var char = pa_1[_i];
        if (char == '(') {
            stack.push({
                "key": key.join('').trim(),
                "childs": null
            });
            stack.push(char);
            key = [];
        }
        else if (char == ')') {
            stack.push({
                "key": key.join('').trim(),
                "childs": null
            });
            key = [];
            var list = [];
            var item = void 0;
            item = stack.pop();
            while (item != '(') {
                list.push(item);
                item = stack.pop();
            }
            stack[stack.length - 1].childs = list;
        }
        else if (char == ',') {
            stack.push({
                "key": key.join('').trim(),
                "childs": null
            });
            key = [];
        }
        else {
            key.push(char);
        }
    }
    return stack.pop();
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