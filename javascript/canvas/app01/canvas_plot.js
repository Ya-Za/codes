'use strict'

class Plot {
    constructor(canvas) {
        this.canvas = canvas
        
        this.color = 'blue'
        this.radius = 5

        this.init()
    }

    init() {
        this.ctx = canvas.getContext('2d')
        this.width = canvas.width
        this.height = canvas.height
        this.halfwidth = Math.floor(this.width / 2)
        this.halfheight = Math.floor(this.height / 2)

        this.ctx.fillStyle = this.color
        this.ctx.strokeStyle = this.color
    }

    static get_line(x_min, x_max, y_min, y_max) {
        var m = (y_max - y_min) / (x_max - x_min)
        var b = y_min - m * x_min
        return {
            m,
            b
        }
    }

    static range(start, stop, step = 1) {
        var res = []
        for (let x = start; x <= stop; x += step) {
            res.push(x)
        }

        return res
    }

    static linspace(start, stop, number) {
        var data = Plot.range(start, stop, (stop - start) / (number - 1))
        if (data.length < number) {
            data.push(stop)
        }

        return data
    }

    static linear_transform(x, line) {
        return x.map(value => (line.m * value) + line.b)
    }

    get_x_px(x) {
        var x_min = Math.min(...x)
        var x_max = Math.max(...x)
        var x_px_min = -this.halfwidth
        var x_px_max = this.width - 1 - this.halfwidth

        return Plot.linear_transform(
            x,
            Plot.get_line(x_min, x_max, x_px_min, x_px_max)
        )
    }

    get_y_px(y) {
        var y_min = Math.min(...y)
        var y_max = Math.max(...y)
        var y_px_min = -this.halfheight
        var y_px_max = this.height - 1 - this.halfheight

        return Plot.linear_transform(
            y,
            Plot.get_line(y_min, y_max, y_px_min, y_px_max)
        )
    }

    plot(x, y, type) {
        // pixel
        // - x
        var x_px = this.get_x_px(x)
        // - y
        var y_px = this.get_y_px(y)

        // H (transform matrix)
        var H = [
            [1, 0, this.halfwidth],
            [0, -1, this.halfheight]
        ]

        var data = [x_px, y_px, math.ones(x_px.length)._data]
        data = math.multiply(H, data)
        data = math.floor(data)

        this.plot_data(data, type)
    }

    get_px_index(x, y) {
        return 4 * (y * this.width + x)
    }

    plot_data_old(data, color) {
        var img = this.ctx.getImageData(0, 0, this.width, this.height)
        for (let i = 0, len = data[0].length; i < len; i++) {
            let index = this.get_px_index(data[0][i], data[1][i])
            img.data[index + 0] = color[0]
            img.data[index + 1] = color[1]
            img.data[index + 2] = color[2]
            img.data[index + 3] = color[3]
        }

        this.ctx.putImageData(img, 0, 0)
    }

    plot_data(data, type) {
        if (type == 'line') {
            this.line_plot(data)
        } else if(type == 'scatter') {
            this.scatter_plot(data)
        }
    }

    line_plot(data) {
        this.ctx.moveTo(data[0][0], data[1][0])
        for (let i = 1, len = data[0].length; i < len; i++) {
            this.ctx.lineTo(data[0][i], data[1][i])
        }

        this.ctx.stroke()
    }

    scatter_plot(data) {
        for (let i = 0, len = data[0].length; i < len; i++) {
            this.fill_circle(data[0][i], data[1][i])
        }
    }

    fill_circle(x, y) {
        this.ctx.beginPath()
        this.ctx.arc(x, y, this.radius, 0, 2 * Math.PI)
        this.ctx.fill()
    }

    plot_function(fn, x_min, x_max, number = 100, type = 'line') {
        this.init()

        if (number > this.width) {
            number = this.width
        }

        var x = Plot.linspace(x_min, x_max, number)
        var y = x.map(value => fn(value))

        this.plot(x, y, type)
    }
}