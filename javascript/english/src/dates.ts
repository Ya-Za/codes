import { integer } from "./numbers";

const MONTHES = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
]

export function readDate(day: number, month: number, year: number, splitYear = false, british = false): string {
    // day
    let dayName = integer(day.toString(), true);
    // month
    let monthName = MONTHES[month - 1];
    // year
    let yearName = "";
    if (splitYear) {
        // - first part (--xx)
        let yearFirstPart = year % 100;
        let yearFirstPartName = "";
        if (yearFirstPart == 0) {
            yearFirstPartName = "hundred";
        } else {
            yearFirstPartName = integer(yearFirstPart.toString());
            if (yearFirstPart < 10) {
                yearFirstPartName = "[oh/hundred [and]]" + yearFirstPartName;
            }
        }

        // - second part (xx--)
        let yearSecondPart = Math.floor(year / 100);
        let yearSecondPartName = integer(yearSecondPart.toString());
        //
        yearName = yearSecondPartName + " " + yearFirstPartName;
    } else {
        yearName = integer(year.toString());
    }

    if (british) {
        return `the ${dayName} of ${monthName}, ${yearName}`;
    } else {
        return `${monthName} [the] ${dayName}, ${yearName}`;
    }
}