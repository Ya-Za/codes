/**
 * Node
 */
export default class NodeTree {
    name: string;
    parent: Node;
    childs: Node[];

    constructor(name: string) {
        this.name = name;
        this.parent = null;
        this.childs = [];
    }
}
