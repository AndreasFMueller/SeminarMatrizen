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
84
92
96
97
# Kapitel 5
116
117
119
121
122
124
149
150
151
155
# Kapitel 6
164
# Kapitel 7
176
179
180
181
189
191
192
197
# Kapitel 8
208
214
216
218
222
224
# Kapitel 9
236
239
240
243
248
249
250
251
252
# Kapitel 10
266
267
268
269
271
274
280
281
283
# Kapitel 11
291
295
299
300
301
302
304
305
309
310
# Kapitel 12
323
324
325
# Kapitel 13
328
330
334
338
339
# Kapitel 14
342
344
345
347
349
350
# Kapitel 15
354
355
356
357
358
362
367
368
369
371
372
373
# Kapitel 16
383
384
385
387
# Kapitel 17
396
# Kapitel 18
400
401
404
407
410
416
418
419
420
421
# Kapitel 19
424
425
426
427
428
434
# Kapitel 20
438
440
446
447
448
450
# Kapitel 21
454
455
456
458
459
EOF
