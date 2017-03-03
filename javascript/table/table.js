class Table {
    static create(rows = 0, cols) {
        if (typeof(cols) == 'undefined') {
            var cols = rows
        }
        var table = document.createElement('table')
        
        for (let r = 0; r < rows; r++) {
            let row = table.insertRow(r)
            for (let c = 0; c < cols; c++) {
                row.insertCell(c)
            }
        }

        return table
    }

    static get(table, row, col) {
        return table.rows[row].cells[col]
    }

    static set(table, row, col, item) {
        if (typeof(item) == 'string' || typeof(item) == 'number') {
            item = document.createTextNode(item)
        }
        var td = Table.get(table, row, col)
        td.appendChild(item)
    }

    static from_array(arr) {
        var rows = arr.length
        var cols = arr[0].length

        var table = Table.create(rows, cols)

        for (let r = 0; r < rows; r++) {
            for (let c = 0; c < cols; c++) {
                Table.set(table, r, c, arr[r][c])
            }
        }

        return table
    }
}