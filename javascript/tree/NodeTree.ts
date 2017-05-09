/**
 * Node
 */
export default class NodeTree {
    constructor(
        public name: string,
        public parent: NodeTree = null,
        public childs: NodeTree[] = [],
    ) { }
}
