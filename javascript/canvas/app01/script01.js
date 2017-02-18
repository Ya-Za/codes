var Shape = function (id, x, y) {
    this.id = id;
    this.move(x, y);
    this.hello = function() {
        console.log('Hello')
    }
};
Shape.prototype.move = function (x, y) {
    this.x = x;
    this.y = y;
};