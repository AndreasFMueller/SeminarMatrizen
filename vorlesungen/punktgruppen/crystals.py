from manim import *

import math as m
import numpy as np
import itertools as it

# configure style
config.background_color = '#202020'
config.tex_template.add_to_preamble(
    r"\usepackage[p,osf]{scholax}"
    r"\usepackage{amsmath}"
    r"\usepackage[scaled=1.075,ncf,vvarbb]{newtxmath}"
)

# scenes
class Geometric2DSymmetries(Scene):
    def construct(self):
        # title
        title = Tex(r"Geometrische \\ Symmetrien")
        title.scale(1.5)
        self.play(Write(title))
        self.wait()
        self.play(FadeOut(title))
        self.wait()

        self.intro()
        self.cyclic()
        self.dihedral()

    def intro(self):
        # create square
        square = Square()
        square.set_fill(PINK, opacity=.5)
        self.play(SpinInFromNothing(square))
        self.wait()

        # the action of doing nothing
        action = MathTex(r"\mathbb{1}")
        self.play(Write(action))
        self.play(ApplyMethod(square.scale, 1.2))
        self.play(ApplyMethod(square.scale, 1/1.2))
        self.play(FadeOut(action))

        # show some reflections
        axis = DashedLine(2 * LEFT, 2 * RIGHT)
        sigma = MathTex(r"\sigma")
        sigma.next_to(axis, RIGHT)

        self.play(Create(axis))
        self.play(Write(sigma))

        self.play(ApplyMethod(square.flip, RIGHT))
        self.wait()

        for d in [UP + RIGHT, UP]:
            self.play(
                Rotate(axis, PI/4),
                Rotate(sigma, PI/4, about_point=ORIGIN))

            self.play(Rotate(sigma, -PI/4), run_time=.5)
            self.play(ApplyMethod(square.flip, d))

        self.play(
            FadeOutAndShift(sigma),
            Uncreate(axis))

        # show some rotations
        dot = Dot(UP + RIGHT)
        figure = VGroup(square, dot)

        rot = MathTex(r"r")
        self.play(Write(rot), Create(dot))

        last = rot
        for newrot in map(MathTex, [r"r", r"r^2", r"r^3"]):
            self.play(
                ReplacementTransform(last, newrot),
                Rotate(figure, PI/2, about_point=ORIGIN))
            self.wait()
            last = newrot

        self.play(Uncreate(dot), FadeOut(square), FadeOut(last))


    def cyclic(self):
        # create symmetric figure
        figure = VGroup()
        prev = [1.5, 0, 0]
        for i in range(1,6):
            pos = [
                1.5*m.cos(2 * PI/5 * i),
                1.5*m.sin(2 * PI/5 * i),
                0
            ]

            if prev:
                line = Line(prev, pos)
                figure.add(line)

            dot = Dot(pos, radius=.1)
            if i == 5:
                dot.set_fill(RED)

            prev = pos
            figure.add(dot)

        group = MathTex(r"G = \langle r \rangle")
        self.play(Write(group), run_time = 2)
        self.wait()
        self.play(ApplyMethod(group.to_edge, UP))

        actions = map(MathTex, [
            r"\mathbb{1}", r"r", r"r^2",
            r"r^3", r"r^4", r"\mathbb{1}"])

        action = next(actions, MathTex(r"r"))
        
        self.play(Create(figure))
        self.play(Write(action))
        self.wait()

        for i in range(5):
            newaction = next(actions, MathTex(r"r"))
            self.play(
                ReplacementTransform(action, newaction),
                Rotate(figure, 2*PI/5, about_point=ORIGIN))
            action = newaction

        self.play(Uncreate(figure), FadeOut(action))

        whole_group = MathTex(
            r"G = \langle r \rangle" 
            r"= \left\{\mathbb{1}, r, r^2, r^3, r^4 \right\}")

        self.play(ApplyMethod(group.move_to, ORIGIN))
        self.play(ReplacementTransform(group, whole_group))
        self.wait()

        cyclic = MathTex(
            r"Z_n = \langle r \rangle" 
            r"= \left\{\mathbb{1}, r, r^2, \dots, r^{n-1} \right\}")

        cyclic_title = Tex(r"Zyklische Gruppe")
        cyclic_title.next_to(cyclic, UP * 2)

        cyclic.scale(1.2)
        cyclic_title.scale(1.2)

        self.play(ReplacementTransform(whole_group, cyclic))
        self.play(FadeInFrom(cyclic_title, UP))

        self.wait(5)
        self.play(FadeOut(cyclic), FadeOut(cyclic_title))

    def dihedral(self):
        # create square
        square = Square()
        square.set_fill(PINK, opacity=.5)

        # generator equation
        group = MathTex(
            r"G = \langle \sigma, r \,|\,",
            r"\sigma^2 = \mathbb{1},",
            r"r^4 = \mathbb{1},",
            r"(\sigma r)^2 = \mathbb{1} \rangle")

        self.play(Write(group), run_time = 2)
        self.wait()
        self.play(ApplyMethod(group.to_edge, UP))
        self.play(FadeIn(square))

        axis = DashedLine(2 * LEFT, 2 * RIGHT)
        sigma = MathTex(r"\sigma^2 = \mathbb{1}")
        sigma.next_to(axis, RIGHT)
        self.play(Create(axis), Write(sigma))
        self.play(ApplyMethod(square.flip, RIGHT))
        self.play(ApplyMethod(square.flip, RIGHT))
        self.play(Uncreate(axis), FadeOut(sigma))

        # rotations
        dot = Dot(UP + RIGHT)
        rot = MathTex(r"r^4 = \mathbb{1}")
        rot.next_to(square, DOWN * 3)

        figure = VGroup(dot, square)

        self.play(Write(rot), Create(dot))
        for i in range(4):
            self.play(Rotate(figure, PI/2))
        self.play(FadeOut(rot), Uncreate(dot))

        # rotation and flip
        action = MathTex(r"(\sigma r)^2 = \mathbb{1}")
        action.next_to(square, DOWN * 5)

        dot = Dot(UP + RIGHT)
        axis = DashedLine(2 * LEFT, 2 * RIGHT)
        self.play(Create(dot), Create(axis), Write(action))

        figure = VGroup(dot, square)

        for i in range(2):
            self.play(Rotate(figure, PI/2))
            self.play(ApplyMethod(figure.flip, RIGHT))
            self.wait()

        self.play(Uncreate(dot), Uncreate(axis), FadeOut(action))
        self.play(FadeOut(square))

        # equation for the whole
        whole_group = MathTex(
            r"G &= \langle \sigma, r \,|\,"
            r"\sigma^2 = r^4 = (\sigma r)^2 = \mathbb{1} \rangle \\"
            r"&= \left\{"
            r"\mathbb{1}, r, r^2, r^3, \sigma, \sigma r, \sigma r^2, \sigma r^3"
            r"\right\}")

        self.play(ApplyMethod(group.move_to, ORIGIN))
        self.play(ReplacementTransform(group, whole_group))
        self.wait(2)

        dihedral = MathTex(
            r"D_n &= \langle \sigma, r \,|\,"
            r"\sigma^2 = r^n = (\sigma r)^2 = \mathbb{1} \rangle \\"
            r"&= \left\{"
            r"\mathbb{1}, r, r^2, \dots, \sigma, \sigma r, \sigma r^2, \dots"
            r"\right\}")

        dihedral_title = Tex(r"Diedergruppe: Symmetrien eines \(n\)-gons")
        dihedral_title.next_to(dihedral, UP * 2)

        dihedral.scale(1.2)
        dihedral_title.scale(1.2)

        self.play(ReplacementTransform(whole_group, dihedral))
        self.play(FadeInFrom(dihedral_title, UP))

        self.wait(5)
        self.play(FadeOut(dihedral), FadeOut(dihedral_title))


class Geometric3DSymmetries(ThreeDScene):
    def construct(self):
        self.symmetric()


    @staticmethod
    def get_cube():
        verts = np.array(list(it.product(*3 * [[-1, 1]])))
        edges = [
            (v1, v2)
            for v1, v2 in it.combinations(verts, 2)
            if sum(v1 == v2) == 2
        ]
        corner_dots = Group(*[
            Sphere().set_height(0.25).move_to(vert)
            for vert in verts
        ])
        corner_dots.set_color(GREY_B)
        edge_rods = Group(*[
            Line3D(v1, v2)
            for v1, v2 in edges
        ])

        faces = Cube(square_resolution=(10, 10))
        faces.set_height(2)
        faces.set_color(BLUE_E, 0.3)
        # faces.add_updater(lambda m: m.sort(lambda p: np.dot(p, [np.sign(self.euler_angles[0]) * 0.2, -1, 0.2])))

        cube = Group(corner_dots, edge_rods, faces)
        cube.corner_dots = corner_dots
        cube.edge_rods = edge_rods
        cube.faces = faces
        return cube

    def symmetric(self):
        self.renderer.camera.light_source.move_to(3*IN) # changes the source of the light
        self.set_camera_orientation(phi=60 * DEGREES, theta=5 * DEGREES)

        cube = Cube()
        self.play(GrowFromCenter(cube))

        axes = list(
            map(lambda v: v / np.linalg.norm(v),
            map(np.array, [
                [0, 0, 1],
                [0, 1, 1],
                [1, 1, 1],
            ])
        ))
        angles = [ PI, PI, PI * 2/3 ]
        lines = list(map(lambda x: Line(-2 * x, 2 * x), axes))

        camera_thetas = list(map(lambda x: x * DEGREES, [10, 100, 110]))
        for axis, line, angle, camera_angle in zip(axes, lines, angles, camera_thetas):
            self.move_camera(theta=camera_angle)
            self.play(Create(line))
            self.play(Rotate(cube, angle, axis=axis, run_time=3))

        self.wait(7)


class AlgebraicSymmetries(Scene):
    def construct(self):
        # title
        title = Tex(r"Algebraische \\ Symmetrien")
        title.scale(1.5)
        self.play(Write(title))
        self.wait()
        self.play(FadeOut(title))
        self.wait()

        self.cyclic()
        self.matrices()

    def cyclic(self):
        # show the i product
        product = MathTex(
            r"1", r"\cdot i &= i \\",
            r"i \cdot i &= -1 \\",
            r"-1 \cdot i &= -i \\",
            r"-i \cdot i &= 1")
        product.scale(1.5)
        
        for part in product:
            self.play(Write(part))

        self.wait()
        self.play(ApplyMethod(product.scale, 1/1.5))

        # gather in group
        group = MathTex(r"G = \left\{ 1, i, -1, -i \right\}")
        self.play(ReplacementTransform(product, group))
        self.wait()

        # show Z4
        grouppow =  MathTex(
            r"G &= \left\{ 1, i, i^2, i^3 \right\} \\",
            r"Z_4 &= \left\{ \mathbb{1}, r, r^2, r^3 \right\}")
        self.play(ReplacementTransform(group, grouppow[0]))
        self.wait()

        self.play(Write(grouppow[1]))
        self.wait()
        self.play(ApplyMethod(grouppow.to_edge, UP))

        # define morphisms
        morphism = MathTex(r"\phi: Z_4 \to G \\")
        morphism.shift(UP)
        self.play(Write(morphism))

        # show an example
        mappings = MathTex(
            r"\phi(\mathbb{1}) &= 1 \\",
            r"\phi(r) &= i \\",
            r"\phi(r^2) &= i^2 \\",
            r"\phi(r^3) &= i^3 \\")
        mappings.next_to(morphism, DOWN)

        self.play(Write(mappings))
        self.wait()
        self.play(FadeOutAndShift(mappings, DOWN))

        # more general definition
        homomorphism = MathTex(
            r"\phi(r\circ \mathbb{1}) &= i\cdot 1 \\",
            r"&= \phi(r)\cdot\phi(\mathbb{1})")
        homomorphism.next_to(morphism, DOWN).align_to(morphism, LEFT)
        for part in homomorphism:
            self.play(Write(part))

        hom_bracegrp = VGroup(morphism, homomorphism)

        self.play(
            ApplyMethod(grouppow.shift, 2.5 * LEFT),
            ApplyMethod(hom_bracegrp.shift, 2.5 * LEFT))

        hom_brace = Brace(hom_bracegrp, direction=RIGHT)
        hom_text = Tex("Homomorphismus").next_to(hom_brace.get_tip(), RIGHT)
        hom_text_short = MathTex(r"\mathrm{Hom}(G, Z_4)").next_to(hom_brace.get_tip(), RIGHT)

        self.play(Create(hom_brace))
        self.play(Write(hom_text))
        self.play(ReplacementTransform(hom_text, hom_text_short))
        self.wait()

        # self.play(FadeOut(hom_brace), FadeOut(hom_text_short))

        # add the isomorphism part
        isomorphism = Tex(r"\(\phi\) ist bijektiv")
        isomorphism.next_to(homomorphism, DOWN).align_to(homomorphism, LEFT)
        self.play(Write(isomorphism))

        iso_bracegrp = VGroup(hom_bracegrp, isomorphism)

        iso_brace = Brace(iso_bracegrp, RIGHT)
        iso_text = Tex("Isomorphismus").next_to(iso_brace.get_tip(), RIGHT)
        iso_text_short = MathTex("Z_4 \cong G").next_to(iso_brace.get_tip(), RIGHT)

        self.play(
            ReplacementTransform(hom_brace, iso_brace),
            ReplacementTransform(hom_text_short, iso_text))
        self.wait()

        self.play(ReplacementTransform(iso_text, iso_text_short))
        self.wait()

        # create a group for the whole
        morphgrp = VGroup(iso_bracegrp, iso_brace, iso_text_short)

        self.play(
            ApplyMethod(grouppow.to_edge, LEFT),
            ApplyMethod(morphgrp.to_edge, LEFT))
        # self.play(
        #     FadeOutAndShift(grouppow, UP),
        #     FadeOutAndShift(morphgrp, DOWN))

        # draw a complex plane
        plane = ComplexPlane(x_min = -2, x_max = 3)
        coordinates = plane.get_coordinate_labels(1, -1, 1j, -1j)

        roots = list(map(lambda p: Dot(p, fill_color=PINK), (
            [1, 0, 0], [0, 1, 0], [-1, 0, 0], [0, -1, 0]
        )))

        arrow = CurvedArrow(
            1.5 * np.array([m.cos(10 * DEGREES), m.sin(10 * DEGREES), 0]),
            1.5 * np.array([m.cos(80 * DEGREES), m.sin(80 * DEGREES), 0]))
        arrowtext = MathTex("\cdot i")
        arrowtext.move_to(2 / m.sqrt(2) * (UP + RIGHT))

        square = Square().rotate(PI/4).scale(1/m.sqrt(2))
        square.set_fill(PINK).set_opacity(.4)

        figuregrp = Group(plane, square, arrow, arrowtext, *coordinates, *roots)
        figuregrp.to_edge(RIGHT)

        self.play(Create(plane))
        self.play(
            *map(Create, roots),
            *map(Write, coordinates))
        self.wait()
        self.play(FadeIn(square), Create(arrow), Write(arrowtext))

        for _ in range(4):
            self.play(Rotate(square, PI/2))
            self.wait(.5)

        self.play(
            *map(FadeOut, (square, arrow, arrowtext)),
            *map(FadeOut, coordinates),
            *map(FadeOut, roots))
        self.play(Uncreate(plane))
        self.play(
            FadeOutAndShift(grouppow, RIGHT),
            FadeOutAndShift(morphgrp, RIGHT))

        modulo = MathTex(
            r"\phi: Z_4 &\to (\mathbb{Z}/4\mathbb{Z}, +) \\"
            r"\phi(\mathbb{1} \circ r^2) &= 0 + 2 \pmod 4").scale(1.5)
        self.play(Write(modulo))
        self.wait(2)

        self.play(FadeOut(modulo))
        self.wait(3)

    def matrices(self):
        question = MathTex(
            r"D_n &\cong \,? \\"
            r"S_n &\cong \,? \\"
            r"A_n &\cong \,?").scale(1.5)

        answer = MathTex(
            r"D_n &\cong \,?\\"
            r"S_4 &\cong \mathrm{Aut}(Q_8) \\"
            r"A_5 &\cong \mathrm{PSL}_2 (5)").scale(1.5)

        self.play(Write(question))
        self.wait()
        self.play(ReplacementTransform(question, answer))

        self.wait(3)
