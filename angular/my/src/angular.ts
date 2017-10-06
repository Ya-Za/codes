export class Angular {
    readonly document: HTMLDocument;

    constructor(document: HTMLDocument) {
        this.document = document;
    }

    render(obj: any, selector: string, template: string): void {
        // Replace `selector` with `template`
        const src = this.document.getElementById(selector) as HTMLElement;
        src.innerHTML = this.replace(obj, template);
    }
    renderOld(obj: any, selector: string, template: string): void {
        // Replace `selector` with `template`
        template = this.replace(obj, template);
        const src = this.document.getElementById(selector) as HTMLElement;
        const dst = this.parse(template);
        //this.replaceWith(src, dst);
    }
    replace(obj: any, template: string): string {
        const r = /\{\{([^\}]+)\}\}/g;
        return template.replace(r, (x, p1) => obj[p1]);
    }
    parse(template: string): HTMLElement {
        // approaches
        // - parser
        // const parser = new DOMParser();
        // const doc = parser.parseFromString(template, 'text/xml');
        // return doc.firstChild;

        // - wrapper
        const wrapper = document.createElement('div');
        wrapper.innerHTML = template;
        return wrapper.firstElementChild as HTMLElement;
    }
    replaceWith(src: HTMLElement, dst: HTMLElement): void {
        const parent = src.parentElement as HTMLElement;
        parent.replaceChild(dst, src);
    }
}