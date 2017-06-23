import World from "./World";

// world
let canvas = document.querySelector("#canvas") as HTMLCanvasElement;
let fps = 25;

let world = new World(canvas, fps);

// start/stop event listener
var status = "stop";
window.addEventListener("keydown", (e) => {
    // press `space` bar
    if (e.key === " ") {
        if (status === "stop") {
            world.start();
            status = "start";
        } else {
            world.stop();
            status = "stop";
        }

        console.log(status);
    }
})