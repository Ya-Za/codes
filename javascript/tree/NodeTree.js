"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
/**
 * Node
 */
class NodeTree {
    constructor(name, parent = null, childs = []) {
        this.name = name;
        this.parent = parent;
        this.childs = childs;
    }
}
exports.default = NodeTree;
//# sourceMappingURL=NodeTree.js.map