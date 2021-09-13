/*
 * matrix.cpp -- create the cover image
 *
 * (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
 */
#include <ImageMagick-7/Magick++.h>
#include <getopt.h>
#include <iostream>
#include <cstdlib>
#include <cstdio>
#include <string>

class MatrixImage : public Magick::Image {
	Magick::ColorRGB	_schriftfarbe;
	double	_opacity_fade;
public:
	double	opacity_fade() const { return _opacity_fade; }
	void	opacity_fade(double of) { _opacity_fade = of; }
	MatrixImage(Magick::Geometry& geometry, Magick::Color& color,
		Magick::Color& schriftfarbe)
		: Magick::Image(geometry, color), _schriftfarbe(schriftfarbe) {
		_opacity_fade = 0.9;
		strokeColor(schriftfarbe);
		fillColor(schriftfarbe);
		font("Courier");
	}
	void	verticalline(double x, double scale, double startopacity);
	void	verticallines(double width, double scale, double startopacity);
};

void	MatrixImage::verticalline(double x, double scale, double startopacity) {
	std::vector<Magick::Drawable>	objects_to_draw;

	fontPointsize(20 * scale);
	double	heightstep = 16 * scale;

	double	r = (random() % 65525) / 65535.;
	double	initialheight = size().height() * (1 - 0.5 * r);
	initialheight = heightstep * trunc(initialheight / heightstep);
	double	opacity = startopacity;

	for (int i = 0; i < 20; i++) {
		objects_to_draw.push_back(Magick::DrawableStrokeOpacity(opacity));
		objects_to_draw.push_back(Magick::DrawableFillOpacity(opacity));
		char	buffer[2];
		snprintf(buffer, sizeof(buffer), "%d", random() % 10);
		objects_to_draw.push_back(Magick::DrawableText(x, initialheight - i * heightstep, buffer));
		opacity *= opacity_fade();
	}
	draw(objects_to_draw);
}

void	MatrixImage::verticallines(double width, double scale, double startopacity) {
	int	xstep = scale * 12;
	for (int x = 0; x < width; x += xstep) {
		verticalline(x, scale, startopacity);
std::cout << x << std::endl;
	}
}

struct option	longoptions[] = {
{ "foreground",	required_argument,	NULL,	'f' },
{ "background",	required_argument,	NULL,	'b' },
{ "opacity",	required_argument,	NULL,	'o' },
{ "width",	required_argument,	NULL,	'w' },
{ "height",	required_argument,	NULL,	'h' },
{ "scale",	required_argument,	NULL,	's' },
{ NULL,		0,			NULL,	 0  }
};

int	main(int argc, char *argv[]) {
	Magick::InitializeMagick(*argv);
	int	width = 1920;
	int	height = 1080;
	double	opacityfade = 0.9;
	std::string	backgroundcolor("black");
	std::string	foregroundcolor("#66ffcc");
	int	c;
	int	longindex;
	double	scale = 1;
	while (EOF != (c = getopt_long(argc, argv, "f:b:o:w:h:s:", longoptions, &longindex)))
		switch (c) {
		case 'o':
			opacityfade = std::stod(optarg);
			break;
		case 'w':
			width = std::stoi(optarg);
			break;
		case 'h':
			height = std::stoi(optarg);
			break;
		case 's':
			scale = std::stod(optarg);
			break;
		case 'f':
			foregroundcolor = std::string(optarg);
			break;
		case 'b':
			backgroundcolor = std::string(optarg);
			break;
		}

	if (optind >= argc) {
		std::cerr << "no filename" << std::endl;
		return EXIT_FAILURE;
	}
	std::string	filename(argv[optind]);

	Magick::Geometry	geometry(width, height);
	Magick::ColorRGB	background(backgroundcolor);
	Magick::ColorRGB	schriftfarbe(foregroundcolor);

	MatrixImage	image(geometry, background, schriftfarbe);
	image.opacity_fade(opacityfade);

	image.verticallines(image.size().width(), 0.5 * scale, 0.25);
	image.verticallines(image.size().width(), 0.7 * scale, 0.5);
	image.verticallines(image.size().width(), 1 * scale, 1);

	image.write(filename);
}
