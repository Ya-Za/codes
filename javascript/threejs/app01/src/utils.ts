// import * as THREE from "three";
/// <reference path="../node_modules/@types/three/index.d.ts" />

export function movingCube(width: number, height: number) {
    let scene = new THREE.Scene();
    let camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000);
    let renderer = new THREE.WebGLRenderer();
    renderer.setSize(width, height);

    document.body.appendChild(renderer.domElement);

    let geometry = new THREE.BoxGeometry(1, 1, 1);
    let material = new THREE.MeshBasicMaterial({
        color: 0x00ff00
    });
    let cube = new THREE.Mesh(geometry, material);
    scene.add(cube);

    camera.position.z = 5;

    let animate = function () {
        requestAnimationFrame(animate);

        cube.rotation.x += 0.1;
        cube.rotation.y += 0.1;

        renderer.render(scene, camera);
    };

    animate();
}