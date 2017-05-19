"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
/**
 * Node
 */
var NodeTree = (function () {
    function NodeTree(name, parent, childs) {
        if (parent === void 0) { parent = null; }
        if (childs === void 0) { childs = []; }
        this.name = name;
        this.parent = parent;
        this.childs = childs;
    }
    return NodeTree;
}());
exports.default = NodeTree;
//# sourceMappingURL=NodeTree.js.map