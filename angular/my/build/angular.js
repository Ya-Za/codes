define(["require", "exports"], function (require, exports) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    class Angular {
        constructor(document) {
            this.document = document;
        }
        render(obj, selector, template) {
            // Replace `selector` with `template`
            const src = this.document.getElementById(selector);
            src.innerHTML = this.replace(obj, template);
        }
        renderOld(obj, selector, template) {
            // Replace `selector` with `template`
            template = this.replace(obj, template);
            const src = this.document.getElementById(selector);
            const dst = this.parse(template);
            //this.replaceWith(src, dst);
        }
        replace(obj, template) {
            const r = /\{\{([^\}]+)\}\}/g;
            return template.replace(r, (x, p1) => obj[p1]);
        }
        parse(template) {
            // approaches
            // - parser
            // const parser = new DOMParser();
            // const doc = parser.parseFromString(template, 'text/xml');
            // return doc.firstChild;
            // - wrapper
            const wrapper = document.createElement('div');
            wrapper.innerHTML = template;
            return wrapper.firstElementChild;
        }
        replaceWith(src, dst) {
            const parent = src.parentElement;
            parent.replaceChild(dst, src);
        }
    }
    exports.Angular = Angular;
});
//# sourceMappingURL=angular.js.map