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
        self.intro()
        self.cyclic()
        self.dihedral()
        self.circle()

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
            r"C_n = \langle r \rangle" 
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

    def circle(self):
        circle = Circle(radius=2)
        dot = Dot()
        dot.move_to(2 * RIGHT)

        figure = VGroup(circle, dot)
        group_name = MathTex(r"C_\infty")

        # create circle
        self.play(Create(circle))
        self.play(Create(dot))

        # move it around
        self.play(Rotate(figure, PI/3))
        self.play(Rotate(figure, PI/6))
        self.play(Rotate(figure, -PI/3))

        # show name
        self.play(Rotate(figure, PI/4), Write(group_name))
        self.play(Uncreate(figure))

        nsphere = MathTex(r"C_\infty \cong S^1 = \left\{z \in \mathbb{C} : |z| = 1\right\}")
        nsphere_title = Tex(r"Kreisgruppe")
        nsphere_title.next_to(nsphere, 2 * UP)

        nsphere.scale(1.2)
        nsphere_title.scale(1.2)

        self.play(ReplacementTransform(group_name, nsphere))
        self.play(FadeInFrom(nsphere_title, UP))

        self.wait(5)
        self.play(FadeOut(nsphere_title), FadeOut(nsphere))


class Geometric3DSymmetries(ThreeDScene):
    def construct(self):
        self.improper_rotation()
        self.icosahedron()

    def improper_rotation(self):
        # changes the source of the light and camera
        self.renderer.camera.light_source.move_to(3*IN) 
        self.set_camera_orientation(phi=0, theta=0)

        # initial square
        square = Square()
        square.set_fill(PINK, opacity=.5)

        self.play(SpinInFromNothing(square))
        self.wait(2)

        for i in range(4):
            self.play(Rotate(square, PI/2))
            self.wait(.5)

        self.move_camera(phi= 75 * DEGREES, theta = -80 * DEGREES)

        # create sphere from slices
        cyclic_slices = []
        for i in range(4):
            colors = [PINK, RED] if i % 2 == 0 else [BLUE_D, BLUE_E]
            cyclic_slices.append(ParametricSurface(
                    lambda u, v: np.array([
                        np.sqrt(2) * np.cos(u) * np.cos(v),
                        np.sqrt(2) * np.cos(u) * np.sin(v),
                        np.sqrt(2) * np.sin(u)
                    ]),
                    v_min=PI/4 + PI/2 * i,
                    v_max=PI/4 + PI/2 * (i + 1),
                    u_min=-PI/2, u_max=PI/2,
                    checkerboard_colors=colors, resolution=(10,5)))

        self.play(FadeOut(square), *map(Create, cyclic_slices))

        axis = Line3D(start=[0,0,-2.5], end=[0,0,2.5])

        axis_name = MathTex(r"r \in C_4")
        # move to yz plane
        axis_name.rotate(PI/2, axis = RIGHT)
        axis_name.next_to(axis, OUT)

        self.play(Create(axis))
        self.play(Write(axis_name))
        self.wait()

        cyclic_sphere = VGroup(*cyclic_slices)
        for i in range(4):
            self.play(Rotate(cyclic_sphere, PI/2))
            self.wait()

        # reflection plane
        self.play(FadeOut(cyclic_sphere), FadeIn(square))
        plane = ParametricSurface(
                lambda u, v: np.array([u, 0, v]),
                u_min = -2, u_max = 2,
                v_min = -2, v_max = 2,
                fill_opacity=.3, resolution=(1,1))

        plane_name = MathTex(r"\sigma \in D_4")
        # move to yz plane
        plane_name.rotate(PI/2, axis = RIGHT)
        plane_name.next_to(plane, OUT + RIGHT)

        self.play(Create(plane))
        self.play(Write(plane_name))
        self.wait()

        self.move_camera(phi = 25 * DEGREES, theta = -75 * DEGREES)

        self.play(Rotate(square, PI/2))
        self.play(Rotate(square, PI, RIGHT))

        self.play(Rotate(square, PI/2))
        self.play(Rotate(square, PI, RIGHT))

        self.move_camera(phi = 75 * DEGREES, theta = -80 * DEGREES)

        # create sphere from slices
        dihedral_slices = []
        for i in range(4):
            for j in range(2):
                colors = [PINK, RED] if i % 2 == 0 else [BLUE_D, BLUE_E]
                dihedral_slices.append(ParametricSurface(
                        lambda u, v: np.array([
                            np.sqrt(2) * np.cos(u) * np.cos(v),
                            np.sqrt(2) * np.cos(u) * np.sin(v),
                            np.sqrt(2) * np.sin(u)
                        ]),
                        v_min=PI/2 * j + PI/4 + PI/2 * i,
                        v_max=PI/2 * j + PI/4 + PI/2 * (i + 1),
                        u_min=-PI/2 if j == 0 else 0,
                        u_max=0 if j == 0 else PI/2,
                        checkerboard_colors=colors, resolution=(10,5)))

        dihedral_sphere = VGroup(*dihedral_slices)

        self.play(FadeOut(square), Create(dihedral_sphere))

        for i in range(2):
            self.play(Rotate(dihedral_sphere, PI/2))
            self.play(Rotate(dihedral_sphere, PI, RIGHT))
            self.wait()

        self.wait(5)

    def icosahedron(self):
        pass


class AlgebraicSymmetries(Scene):
    def construct(self):
        self.cyclic()
        # self.matrices()

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
        self.wait(2)

        # show Z4
        grouppow =  MathTex(
            r"G &= \left\{ 1, i, i^2, i^3 \right\} \\",
            r"C_4 &= \left\{ \mathbb{1}, r, r^2, r^3 \right\}")
        self.play(ReplacementTransform(group, grouppow[0]))
        self.wait(2)

        self.play(Write(grouppow[1]))
        self.wait()
        self.play(ApplyMethod(grouppow.to_edge, UP))

        # define morphisms
        morphism = MathTex(r"\phi: C_4 \to G \\")
        morphism.shift(UP)
        self.play(Write(morphism))
        self.wait()

        # show an example
        mappings = MathTex(
            r"\phi(\mathbb{1}) &= 1 \\",
            r"\phi(r) &= i \\",
            r"\phi(r^2) &= i^2 \\",
            r"\phi(r^3) &= i^3 \\")
        mappings.next_to(morphism, DOWN)

        self.play(Write(mappings))
        self.wait(3)
        self.play(FadeOutAndShift(mappings, DOWN))

        # more general definition
        homomorphism = MathTex(
            r"\phi(r\circ \mathbb{1}) &= \phi(r)\cdot\phi(\mathbb{1}) \\",
            r"&= i\cdot 1")
        homomorphism.next_to(morphism, DOWN).align_to(morphism, LEFT)
        for part in homomorphism:
            self.play(Write(part))
            self.wait()

        hom_bracegrp = VGroup(morphism, homomorphism)

        self.play(
            ApplyMethod(grouppow.shift, 3 * LEFT),
            ApplyMethod(hom_bracegrp.shift, 3 * LEFT))

        hom_brace = Brace(hom_bracegrp, direction=RIGHT)
        hom_text = Tex("Homomorphismus").next_to(hom_brace.get_tip(), RIGHT)
        hom_text_short = MathTex(r"\mathrm{Hom}(C_4, G)").next_to(hom_brace.get_tip(), RIGHT)

        self.play(Create(hom_brace))
        self.play(Write(hom_text))
        self.wait()
        self.play(ReplacementTransform(hom_text, hom_text_short))
        self.wait()

        # add the isomorphism part
        isomorphism = Tex(r"\(\phi\) ist bijektiv")
        isomorphism.next_to(homomorphism, DOWN).align_to(homomorphism, LEFT)
        self.play(Write(isomorphism))

        iso_bracegrp = VGroup(hom_bracegrp, isomorphism)

        iso_brace = Brace(iso_bracegrp, RIGHT)
        iso_text = Tex("Isomorphismus").next_to(iso_brace.get_tip(), RIGHT)
        iso_text_short = MathTex("C_4 \cong G").next_to(iso_brace.get_tip(), RIGHT)

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

        # draw a complex plane
        plane = ComplexPlane(x_range = [-2.5, 2.5])
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

        figuregrp = VGroup(plane, square, arrow, arrowtext, *coordinates, *roots)
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
            r"\phi: C_4 &\to (\mathbb{Z}/4\mathbb{Z}, +) \\"
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
