#! /bin/bsh
#
# farbseiten.sh -- Formattierung der Farbseiteninfo für die Druckerei
#
# (c) 2020 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
awk 'BEGIN {
	result = ""
	counter = 0
} 
/^#/ {
	next
}
{
	if (length(result) == 0) {
		result = $1
	} else {
		result = sprintf("%s,%d", result, $1)
	}
	counter++
}
END {
	printf("%s\n", result)
	printf("Anzahl Farbseiten: %d\n", counter)
}' <<EOF
# Kapitel 1
19
# Kapitel 2
30
31
32
37
39
51
57
59
66
# Kapitel 3
# Kapitel 4
82
90
94
95
# Kapitel 5
114
115
117
119
120
122
147
148
149
153
# Kapitel 6
162
# Kapitel 7
174
177
178
179
187
189
190
195
# Kapitel 8
206
212
214
216
220
222
# Kapitel 9
234
237
238
241
246
247
248
249
250
# Kapitel 10
264
265
266
267
269
272
278
279
281
# Kapitel 11
289
293
297
298
299
300
302
303
307
308
# Kapitel 12
321
322
323
# Kapitel 13
326
328
332
336
337
# Kapitel 14
340
342
343
345
347
348
# Kapitel 15
352
353
354
355
356
360
365
366
367
369
370
371
# Kapitel 16
381
382
383
385
# Kapitel 17
394
# Kapitel 18
398
399
402
405
408
414
416
417
418
419
# Kapitel 19
422
423
424
425
426
432
# Kapitel 20
436
438
444
445
446
448
# Kapitel 21
452
453
454
456
457
EOF
