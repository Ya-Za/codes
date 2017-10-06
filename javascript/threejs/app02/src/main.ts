import * as THREE from "three";

function main() {
    let canvas = document.querySelector("#canvas") as HTMLCanvasElement;
    makeScene(canvas);
}

function makeScene(canvas: HTMLCanvasElement): void {
    // Scene
    let scene = new THREE.Scene();
    // - cube
    let cube = new THREE.Mesh(
        new THREE.BoxGeometry(1, 1, 1),
        new THREE.MeshBasicMaterial({ color: 0x00FF00 })
    )
    scene.add(cube);
    // Camera
    let camera = new THREE.PerspectiveCamera(60, canvas.width / canvas.height, 0.1, 1000);
    camera.position.z = 5;

    // Renderer
    let renderer = new THREE.WebGLRenderer({ canvas: canvas });

    // Render
    function animate() {
        requestAnimationFrame(animate);

        cube.rotation.x += 0.1;
        cube.rotation.y += 0.1;

        renderer.render(scene, camera);
    }

    animate();
}

main();