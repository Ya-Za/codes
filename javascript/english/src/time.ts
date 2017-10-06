import { integer } from "./numbers";

export function formal(time: string, twelve_hour = false): string {
    let [h, m] = splitTime(time);

    let suffix = "";
    if (twelve_hour) {
        suffix = ampm(h);
        h = bringToTwelveHour(h);
    }

    let hName = integer(h.toString());
    let mName: string;
    if (m == 0) {
        mName = "o'clock";
    } else {
        mName = integer(m.toString());
        if (m < 10) {
            mName = "[oh] " + mName;
        }
    }

    return hName + " " + mName + suffix;

}

export function informal(time: string): string {
    let [h, m] = splitTime(time);
    let hName: string;
    let mName: string;
    let pastOrTo: string;
    let suffix: string;

    // past/to
    if (m == 0) {
        pastOrTo = "";
    } else if (m <= 30) {
        pastOrTo = "past";
    } else {
        pastOrTo = "to";

        m = 60 - m;
        h = h + 1;
    }

    // minute
    if (m == 0) {
        mName = "o'clock";
    } else {
        if (m == 15) {
            mName = "[a] quarter";
        } else if (m == 30) {
            mName = "half";
        } else {
            mName = integer(m.toString());
        }

        if (m == 1) {
            mName += " [minute]";
        } else {
            mName += " [minutes]";
        }
    }

    // suffix
    if (h == 0 || h == 24) {
        suffix = "at midnight";
    } else if (h == 6) {
        suffix = "at sunrise/dawn";
    } else if (h == 12) {
        suffix = "at midday/noon";
    } else if (h == 18) {
        suffix = "at sunset/dusk";
    } else if (h < 12) {
        suffix = "in the morning";
    } else if (h < 18) {
        suffix = "in the afternoon";
    } else {
        suffix = "in the evening";
    }

    // hour
    h = bringToTwelveHour(h);
    hName = integer(h.toString());

    // time
    if (m == 0) {
        return `${hName} ${mName} ${suffix}`;
    }
    return `${mName} ${pastOrTo} ${hName} ${suffix}`;
}

function splitTime(time: string): [number, number] {
    const parts = time.split(":");

    const h = Number(parts[0]);
    const m = Number(parts[1]);

    return [h, m];
}

function bringToTwelveHour(h: number): number {
    if (h == 0) {
        h = 12;
    } else if (h > 12) {
        h = h - 12;
    }

    return h;
}

function ampm(h: number): string {
    if (h >= 12) {
        return " pm";
    }
    return " am";
}

