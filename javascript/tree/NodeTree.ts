/**
 * Node
 */
export default class NodeTree {
    name: string;
    parent: NodeTree;
    childs: NodeTree[];

    constructor(name: string) {
        this.name = name;
        this.parent = null;
        this.childs = [];
    }
}
