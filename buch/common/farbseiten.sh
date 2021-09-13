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
39
51
57
59
66
# Kapitel 3
# Kapitel 4
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
# Kapitel 6
162
# Kapitel 7
174
177
178
186
188
189
194
# Kapitel 8
212
216
220
222
# Kapitel 9
234
237
238
241
245
246
247
248
249
# Kapitel 10
262
263
264
265
266
268
270
276
277
279
# Kapitel 11
286
290
294
295
296
297
299
303
304
# Kapitel 12
317
318
319
# Kapitel 13
322
324
328
332
333
# Kapitel 14
336
338
339
341
343
344
# Kapitel 15
348
349
350
351
352
361
362
363
365
366
367
# Kapitel 16
377
378
379
381
383
# Kapitel 17
390
# Kapitel 18
394
395
398
401
404
410
412
413
414
415
# Kapitel 19
418
419
420
421
422
428
# Kapitel 20
432
434
440
441
442
444
# Kapitel 21
448
449
450
452
453
EOF
