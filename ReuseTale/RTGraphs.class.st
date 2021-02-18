Class {
	#name : #RTGraphs,
	#superclass : #Object,
	#category : #'ReuseTale-model'
}

{ #category : #graphs }
RTGraphs class >> codeByDate [
<script>
| x y z r c p |
	x := OrderedCollection new.
	y := OrderedCollection new.
	z := OrderedCollection new.
	r := Random new.
	RTPrototypeDataRepository prototypes do: [ :proto |
		x add: proto mostRecentVersionDate julianDayNumber.
		y add: proto nbSubSystems .
		z add: (proto nbReusedComponents).
		 ].
	c := RSChart new.
	p := RSScatterPlot new x: x y: y.
	p color: Color blue translucent.
	p processBlock: [ :shapes | 
		shapes models: z.
		RSNormalizer size
			shapes: shapes;
			from: 2;
			to: 7;
			normalize: #yourself.
		RSNormalizer color 
			shapes: shapes;
			normalize: #yourself.
		shapes translucent ].
	c addPlot: p.

	c addDecoration: (RSHorizontalTick new labelConversion: [ :val | Date julianDayNumber: val ]; useDiagonalLabel; yourself ).
	c addDecoration: RSVerticalTick new.

	c open
]

{ #category : #'subsystems graphs' }
RTGraphs class >> nbOfUsedSubsystemsDuringYears [
	<script>
	| prototypes x chart nbPrototypes yNbUsedSubsystems lineNbUsedSubsystems |
	prototypes := RTPrototypeDataRepository getPrototypesFromOlderToMostRecent.
	nbPrototypes := prototypes size.
	
	x := OrderedCollection new. "X : Each prototypes ordered by most recent year"
	yNbUsedSubsystems := OrderedCollection new. "Y : Nb of used subsystems"
	
	prototypes do:[ :p |
		x add: p mostRecentVersionDate julianDayNumber.
		"Computing reuse source code percent"	
		yNbUsedSubsystems add: p subSystems size.
	].

	"Create lines"
	lineNbUsedSubsystems := RSBarPlot new x: x y: yNbUsedSubsystems.

	chart := RSChart new.
	chart addPlot: lineNbUsedSubsystems.
	chart maxValueY: (RTPrototypeDataRepository subSystems size).
	
	"Chart style"
	chart title: 'Nb of used subsystems during years'.
	chart xlabel: 'Years' offset: 20.
	chart ylabel: 'Nb'.
	chart addDecoration: (RSHorizontalTick new labelConversion: [ :val | (Date julianDayNumber: val) year ]; numberOfTicks: nbPrototypes; yourself).
	chart addDecoration: (RSVerticalTick new).
	
	"Open the Chart"
	chart show.

]

{ #category : #graphs }
RTGraphs class >> nbProtoByYearCumulated [
<script>
| x y  r c  nb p2   datas |
	x := OrderedCollection new.
	y := OrderedCollection new.

	r := Random new.
	datas := RTPrototypeDataRepository getPrototypesByYear associations asSortedCollection: [ :a :b | a key < b key].

	datas do: [ :dataList |
		x add: dataList key.
		nb := 0.
		dataList value do: [ :proto | nb := nb + proto nbReusedComponents  ].
		y add: nb.
		 ].
	c := RSChart new.
	p2 := RSLinePlot new x: x copy y: y.
	
	c addPlot: p2.

	c addDecoration: (RSHorizontalTick new labelConversion: [ :val | Date julianDayNumber: val ]; useDiagonalLabel; numberOfTicks: 15; yourself ).
	c addDecoration: RSVerticalTick new.

	c open
]

{ #category : #graphs }
RTGraphs class >> nbReuseClassesAndNewByYearCumulated [
<script>
| x y  c  nb p p2   datas y2 nb2 y3 nb3 p3  paint color decoplot |
	x := OrderedCollection new.
	y := OrderedCollection new.
	y2 := OrderedCollection new.
	y3 := OrderedCollection new.
	datas := RTPrototypeDataRepository getPrototypesByYear associations asSortedCollection: [ :a :b | a key < b key].
		nb := 0.
		nb2 := 0.
		nb3 := 0.
	datas do: [ :dataList |
		dataList value size = 0 ifFalse:[
		x add: dataList key.
		dataList value do: [ :proto | nb := nb + proto nbReusedClasses.
				nb2 := nb2 + proto nbTotalClasses.
				nb3 := nb3 + proto nbClasses ].
		y2 add: nb2.
		y3 add: nb3.
		y add: nb]
		 ].
	

	

	c := RSChart new.
	p := RSLinePlot new x: x y: y.
	p color: color.
	c addPlot: p.
	
	
	color:= Color blue.
	decoplot := RSAreaPlot new x: x y1: y y2: 50.
	paint := LinearGradientPaint fromArray: 
		{0-> (color alpha: 0.3).
		0.8 -> Color transparent}.
	paint start: 0@ -100; stop: 0@ 100.
	decoplot shape paint: paint.
	c addPlot: decoplot.
	p := RSLinePlot new x: x copy y: y.
	p color: color.
	c addPlot: p.

	color:= Color red.
	decoplot := RSAreaPlot new x: x y1: y2 y2: 50.
	paint := LinearGradientPaint fromArray: 
		{0-> (color alpha: 0.3).
		0.8 -> Color transparent}.
	paint start: 0@ -100; stop: 0@ 100.
	decoplot shape paint: paint.
	c addPlot: decoplot.
	p2 := RSLinePlot new x: x copy y: y2.
	p2 color: color.
	c addPlot: p2.

	color:= Color orange.
	decoplot := RSAreaPlot new x: x y1: y3 y2: 50.
	paint := LinearGradientPaint fromArray: 
		{0-> (color alpha: 0.3).
		0.8 -> Color transparent}.
	paint start: 0@ -100; stop: 0@ 100.
	decoplot shape paint: paint.
	c addPlot: decoplot.
	p3 := RSLinePlot new x: x copy y: y3.
	p3 color: color  .
	c addPlot: p3.
	
	

	c addDecoration: (RSHorizontalTick new).
	c addDecoration: (RSVerticalTick new ).

	c open
]

{ #category : #graphs }
RTGraphs class >> nbReuseCompAndNewByYearCumulated [
<script>
| x y  c  nb p p2   datas y2 nb2 y3 nb3 p3  paint color decoplot |
	x := OrderedCollection new.
	y := OrderedCollection new.
	y2 := OrderedCollection new.
	y3 := OrderedCollection new.
	datas := RTPrototypeDataRepository getPrototypesByYear associations asSortedCollection: [ :a :b | a key < b key].
		nb := 0.
		nb2 := 0.
		nb3 := 0.
	datas do: [ :dataList |
		dataList value size = 0 ifFalse:[
		x add: dataList key.
		dataList value do: [ :proto | nb := nb + proto nbReusedComponents.
				nb2 := nb2 + proto nbTotalComponents.
				nb3 := nb3 + proto nbComponents ].
		y2 add: nb2.
		y3 add: nb3.
		y add: nb]
		 ].
	

	

	c := RSChart new.
	p := RSLinePlot new x: x y: y.
	p color: color.
	c addPlot: p.
	
	
	color:= Color blue.
	decoplot := RSAreaPlot new x: x y1: y y2: 50.
	paint := LinearGradientPaint fromArray: 
		{0-> (color alpha: 0.3).
		0.8 -> Color transparent}.
	paint start: 0@ -100; stop: 0@ 100.
	decoplot shape paint: paint.
	c addPlot: decoplot.
	p := RSLinePlot new x: x copy y: y.
	p color: color.
	c addPlot: p.

	color:= Color red.
	decoplot := RSAreaPlot new x: x y1: y2 y2: 50.
	paint := LinearGradientPaint fromArray: 
		{0-> (color alpha: 0.3).
		0.8 -> Color transparent}.
	paint start: 0@ -100; stop: 0@ 100.
	decoplot shape paint: paint.
	c addPlot: decoplot.
	p2 := RSLinePlot new x: x copy y: y2.
	p2 color: color.
	c addPlot: p2.

	color:= Color orange.
	decoplot := RSAreaPlot new x: x y1: y3 y2: 50.
	paint := LinearGradientPaint fromArray: 
		{0-> (color alpha: 0.3).
		0.8 -> Color transparent}.
	paint start: 0@ -100; stop: 0@ 100.
	decoplot shape paint: paint.
	c addPlot: decoplot.
	p3 := RSLinePlot new x: x copy y: y3.
	p3 color: color  .
	c addPlot: p3.
	
	

	c addDecoration: (RSHorizontalTick new).
	c addDecoration: (RSVerticalTick new ).

	c open
]

{ #category : #graphs }
RTGraphs class >> nbReuseCompByYear [
<script>
| x y  r c  nb p p2   datas y2 nb2 |
	x := OrderedCollection new.
	y := OrderedCollection new.
	y2 := OrderedCollection new.
	r := Random new.
	datas := RTPrototypeDataRepository getPrototypesByYear associations asSortedCollection: [ :a :b | a key < b key].

	datas do: [ :dataList |
		dataList value size = 0 ifFalse:[
					nb := 0.
		nb2 := 0.
		x add: dataList key.
		dataList value do: [ :proto | nb := nb + proto nbReusedComponents.
				nb2 := nb2 + proto nbTotalComponents ].
		y2 add: nb2.
		y add: nb]
		 ].
	c := RSChart new.
	p := RSLinePlot new x: x y: y.
	p color: Color blue.
	c addPlot: p.
	
	p2 := RSLinePlot new x: x copy y: y2.
	p2 color: Color red.
	c addPlot: p2.

	c addDecoration: (RSHorizontalTick new).
	c addDecoration: (RSVerticalTick new ).

	c open
]

{ #category : #graphs }
RTGraphs class >> nbReuseCompByYearCumulated [
<script>
| x y  r c  nb p p2   datas y2 nb2 |
	x := OrderedCollection new.
	y := OrderedCollection new.
	y2 := OrderedCollection new.
	r := Random new.
	datas := RTPrototypeDataRepository getPrototypesByYear associations asSortedCollection: [ :a :b | a key < b key].
		nb := 0.
		nb2 := 0.
	datas do: [ :dataList |
		dataList value size = 0 ifFalse:[
		x add: dataList key.
		dataList value do: [ :proto | nb := nb + proto nbReusedComponents.
				nb2 := nb2 + proto nbTotalComponents ].
		y2 add: nb2.
		y add: nb]
		 ].
	c := RSChart new.
	p := RSLinePlot new x: x y: y.
	p color: Color blue.
	c addPlot: p.
	
	p2 := RSLinePlot new x: x copy y: y2.
	p2 color: Color red.
	c addPlot: p2.

	c addDecoration: (RSHorizontalTick new).
	c addDecoration: (RSVerticalTick new ).

	c open
]

{ #category : #graphs }
RTGraphs class >> nbReuseMethodsAndNewByYear [
<script>
| x y  c  nb p p2   datas y2 nb2 y3 nb3 p3  paint color decoplot |
	x := OrderedCollection new.
	y := OrderedCollection new.
	y2 := OrderedCollection new.
	y3 := OrderedCollection new.
	datas := RTPrototypeDataRepository getPrototypesByYear associations asSortedCollection: [ :a :b | a key < b key].

	datas do: [ :dataList |
		dataList value size = 0 ifFalse:[
					nb := 0.
		nb2 := 0.
		nb3 := 0.
		x add: dataList key.
		dataList value do: [ :proto | nb := nb + proto nbReusedMethods.
				nb2 := nb2 + proto nbTotalMethods.
				nb3 := nb3 + proto nbMethods  ].
		y2 add: nb2.
		y3 add: nb3.
		y add: nb]
		 ].
	

	

	c := RSChart new.
	p := RSLinePlot new x: x y: y.
	p color: color.
	c addPlot: p.
	
	
	color:= Color blue.
	decoplot := RSAreaPlot new x: x y1: y y2: 50.
	paint := LinearGradientPaint fromArray: 
		{0-> (color alpha: 0.3).
		0.8 -> Color transparent}.
	paint start: 0@ -100; stop: 0@ 100.
	decoplot shape paint: paint.
	c addPlot: decoplot.
	p := RSLinePlot new x: x copy y: y.
	p color: color.
	c addPlot: p.

	color:= Color red.
	decoplot := RSAreaPlot new x: x y1: y2 y2: 50.
	paint := LinearGradientPaint fromArray: 
		{0-> (color alpha: 0.3).
		0.8 -> Color transparent}.
	paint start: 0@ -100; stop: 0@ 100.
	decoplot shape paint: paint.
	c addPlot: decoplot.
	p2 := RSLinePlot new x: x copy y: y2.
	p2 color: color.
	c addPlot: p2.

	color:= Color orange.
	decoplot := RSAreaPlot new x: x y1: y3 y2: 50.
	paint := LinearGradientPaint fromArray: 
		{0-> (color alpha: 0.3).
		0.8 -> Color transparent}.
	paint start: 0@ -100; stop: 0@ 100.
	decoplot shape paint: paint.
	c addPlot: decoplot.
	p3 := RSLinePlot new x: x copy y: y3.
	p3 color: color  .
	c addPlot: p3.
	
	

	c addDecoration: (RSHorizontalTick new).
	c addDecoration: (RSVerticalTick new ).

	c open
]

{ #category : #graphs }
RTGraphs class >> nbReuseMethodsAndNewByYearCumulated [
<script>
| x y  c  nb p p2   datas y2 nb2 y3 nb3 p3  paint color decoplot |
	x := OrderedCollection new.
	y := OrderedCollection new.
	y2 := OrderedCollection new.
	y3 := OrderedCollection new.
	datas := RTPrototypeDataRepository getPrototypesByYear associations asSortedCollection: [ :a :b | a key < b key].
		nb := 0.
		nb2 := 0.
		nb3 := 0.
	datas do: [ :dataList |
		dataList value size = 0 ifFalse:[
		x add: dataList key.
		dataList value do: [ :proto | nb := nb + proto nbReusedMethods.
				nb2 := nb2 + proto nbTotalMethods.
				nb3 := nb3 + proto nbMethods  ].
		y2 add: nb2.
		y3 add: nb3.
		y add: nb]
		 ].
	

	

	c := RSChart new.
	p := RSLinePlot new x: x y: y.
	p color: color.
	c addPlot: p.
	
	
	color:= Color blue.
	decoplot := RSAreaPlot new x: x y1: y y2: 50.
	paint := LinearGradientPaint fromArray: 
		{0-> (color alpha: 0.3).
		0.8 -> Color transparent}.
	paint start: 0@ -100; stop: 0@ 100.
	decoplot shape paint: paint.
	c addPlot: decoplot.
	p := RSLinePlot new x: x copy y: y.
	p color: color.
	c addPlot: p.

	color:= Color red.
	decoplot := RSAreaPlot new x: x y1: y2 y2: 50.
	paint := LinearGradientPaint fromArray: 
		{0-> (color alpha: 0.3).
		0.8 -> Color transparent}.
	paint start: 0@ -100; stop: 0@ 100.
	decoplot shape paint: paint.
	c addPlot: decoplot.
	p2 := RSLinePlot new x: x copy y: y2.
	p2 color: color.
	c addPlot: p2.

	color:= Color orange.
	decoplot := RSAreaPlot new x: x y1: y3 y2: 50.
	paint := LinearGradientPaint fromArray: 
		{0-> (color alpha: 0.3).
		0.8 -> Color transparent}.
	paint start: 0@ -100; stop: 0@ 100.
	decoplot shape paint: paint.
	c addPlot: decoplot.
	p3 := RSLinePlot new x: x copy y: y3.
	p3 color: color  .
	c addPlot: p3.
	
	

	c addDecoration: (RSHorizontalTick new).
	c addDecoration: (RSVerticalTick new ).

	c open
]

{ #category : #'reuse code percent graphs' }
RTGraphs class >> notReusedInPercentDuringYears [
	<script>
	| prototypes x chart nbPrototypes lineComponents lineClasses lineMethods yComponentsInPercent yClassesInPercent yMethodsInPercent |
	prototypes := RTPrototypeDataRepository getPrototypesFromOlderToMostRecent.
	nbPrototypes := prototypes size.
	
	x := OrderedCollection new. "X : Each prototypes ordered by most recent year"

	yComponentsInPercent := OrderedCollection new. "Y : Percent of components"
	yClassesInPercent := OrderedCollection new. "Y : Percent of classes"
	yMethodsInPercent := OrderedCollection new. "Y : Percent of methods"
	
	prototypes do:[ :p |
		x add: p mostRecentVersionDate julianDayNumber.
		"Computing prototype source code percent"	
		yComponentsInPercent add: ((p nbComponents * 100) / p nbTotalComponents).
		yClassesInPercent add: ((p nbClasses * 100) / p nbTotalClasses).
		yMethodsInPercent add: ((p nbMethods * 100) / p nbTotalMethods).
	].

	"Create lines"
	lineComponents := RSLinePlot new x: x y: yComponentsInPercent.
	lineClasses := RSLinePlot new x: x y: yClassesInPercent.
	lineMethods := RSLinePlot new x: x y: yMethodsInPercent.

	chart := RSChart new.
	chart addPlot: lineComponents.
	chart addPlot: lineClasses.
	chart addPlot: lineMethods.
	
	"Chart style"
	chart title: 'Percent of specific code during years'.
	chart xlabel: 'Years' offset: 20.
	chart ylabel: 'Reuse %'.
	chart addDecoration: (RSHorizontalTick new labelConversion: [ :val | (Date julianDayNumber: val) year ]; numberOfTicks: nbPrototypes; yourself).
	chart addDecoration: (RSVerticalTick new).
	
	"Open the Chart"
	chart show.

]

{ #category : #graphs }
RTGraphs class >> percentageReuseByDates [
<script>
| x y z r c p nb p2 sorted y2 |
	x := OrderedCollection new.
	y := OrderedCollection new.
	z := OrderedCollection new.
	y2 := OrderedCollection new.
	r := Random new.
	sorted := RTPrototypeDataRepository getPrototypesFromOlderToMostRecent.
	sorted do: [ :proto |
		x add: proto mostRecentVersionDate julianDayNumber.
		nb := (proto nbComponents = 0) ifTrue:[proto nbReusedComponents] ifFalse:[proto nbComponents].
		y add: (proto nbReusedComponents / nb).
		z add: (proto  nbSubSystems      ).
		y2 add: proto nbClasses.
		 ].
	c := RSChart new.
	p2 := RSLinePlot new x: x copy y: y2.
	p := RSScatterPlot new x: x y: y.
	p color: Color blue translucent.
	p processBlock: [ :shapes | 
		shapes models: z.
		RSNormalizer size
			shapes: shapes;
			from: 2;
			to: 7;
			normalize: #yourself.
		RSNormalizer color 
			shapes: shapes;
			normalize: #yourself.
		shapes translucent ].
	c addPlot: p.
	c addPlot: p2.

	c addDecoration: (RSHorizontalTick new labelConversion: [ :val | Date julianDayNumber: val ]; useDiagonalLabel; numberOfTicks: 15; yourself ).
	c addDecoration: RSVerticalTick new.

	c open
]

{ #category : #'reuse code percent graphs' }
RTGraphs class >> reuseInPercentDuringYears [
	<script>
	| prototypes x chart nbPrototypes yReuseComponentsInPercent yReuseClassesInPercent yReuseMethodsInPercent lineReuseComponents lineReuseClasses lineReuseMethods |
	prototypes := RTPrototypeDataRepository getPrototypesFromOlderToMostRecent.
	nbPrototypes := prototypes size.
	
	x := OrderedCollection new. "X : Each prototypes ordered by most recent year"
	yReuseComponentsInPercent := OrderedCollection new. "Y : Percent of reuse components"
	yReuseClassesInPercent := OrderedCollection new. "Y : Percent of reuse classes"
	yReuseMethodsInPercent := OrderedCollection new. "Y : Percent of reuse methods"
	
	prototypes do:[ :p |
		x add: p mostRecentVersionDate julianDayNumber.
		"Computing reuse source code percent"	
		yReuseComponentsInPercent add: ((p nbReusedComponents * 100) / p nbTotalComponents).
		yReuseClassesInPercent add: ((p nbReusedClasses * 100) / p nbTotalClasses).
		yReuseMethodsInPercent add: ((p nbReusedMethods * 100) / p nbTotalMethods).
	].

	"Create lines"
	lineReuseComponents := RSLinePlot new x: x y: yReuseComponentsInPercent.
	lineReuseClasses := RSLinePlot new x: x y: yReuseClassesInPercent.
	lineReuseMethods := RSLinePlot new x: x y: yReuseMethodsInPercent.

	chart := RSChart new.
	chart addPlot: lineReuseComponents.
	chart addPlot: lineReuseClasses.
	chart addPlot: lineReuseMethods.
	
	"Chart style"
	chart title: 'Percent of reuse code during years'.
	chart xlabel: 'Years' offset: 20.
	chart ylabel: 'Reuse %'.
	chart addDecoration: (RSHorizontalTick new labelConversion: [ :val | (Date julianDayNumber: val) year ]; numberOfTicks: nbPrototypes; yourself).
	chart addDecoration: (RSVerticalTick new).
	
	"Open the Chart"
	chart show.

]

{ #category : #'reuse code percent graphs' }
RTGraphs class >> reuseLevelByYear [
<script>
| x y  r c  nb p p2   datas y2 nb2 |
	x := OrderedCollection new.
	y := OrderedCollection new.
	y2 := OrderedCollection new.
	r := Random new.
	datas := RTPrototypeDataRepository getPrototypesByYear associations asSortedCollection: [ :a :b | a key < b key].

	datas do: [ :dataList |
		dataList value size = 0 ifFalse:[
		nb := 0.
		nb2 := 0.
		x add: dataList key.
		dataList value do: [ :proto | nb := nb + proto nbReusedComponents.
				nb2 := nb2 + proto nbTotalComponents ].
	
		y add: (nb/nb2) *100]
		 ].
	c := RSChart new.
	p := RSBarPlot new x: x y: y.
	p color: Color blue.
	c addPlot: p.

	c addDecoration: (RSHorizontalTick new).
	c addDecoration: (RSVerticalTick new ).

	c open
]

{ #category : #graphs }
RTGraphs class >> reuseMethodsClassAndCompByYearCumulated [
<script>
| x y  c  nb p p2   datas y2 nb2 y3 nb3 p3  color decoplot paintBlock p1 |
	x := OrderedCollection new.
	y := OrderedCollection new.
	y2 := OrderedCollection new.
	y3 := OrderedCollection new.
	datas := RTPrototypeDataRepository getPrototypesByYear associations asSortedCollection: [ :a :b | a key < b key].
		nb := 0.
		nb2 := 0.
		nb3 := 0.
	datas do: [ :dataList |
		dataList value size = 0 ifFalse:[
		x add: dataList key.
		dataList value do: [ :proto | nb := nb + proto nbReusedMethods .
				nb2 := nb2 + proto nbReusedClasses  .
				nb3 := nb3 + proto nbReusedComponents  ].
		y2 add: nb2.
		y3 add: nb3.
		y add: nb]
		 ].
	
	paintBlock := [ :aColor | 
		| tileCanvas e morph paint |
		tileCanvas := RSCanvas new.
		e := 10@10.
		
		tileCanvas add: (RSBox new color: aColor; extent: e; yourself).
		tileCanvas add: (RSEllipse new 
			color: Color black; 
			extent: e / 4; 
			position: e / 4;
			yourself).
		tileCanvas add: (RSEllipse new 
			color: Color black; 
			extent: e / 4;
			position: e / -4;
			yourself).
		morph := tileCanvas createMorph.
		morph extent: e*(1@0.75).
		morph drawOnMockCanvas.
		paint := AthensCairoPatternSurfacePaint createForSurface: morph surface.
		paint repeat.
		paint ].
	
	c := RSChart new.
	p1 := RSBarPlot new color: (Color fromHexString: '00CCFF'); yourself.
	p1 x: x y: y.
		p2 := RSBarPlot new color: (Color fromHexString: '0099FF') ; yourself.
	p2 x: x y: y2.
		p3 := RSBarPlot new color: (Color fromHexString: '0000FF'); yourself.
	p3 x: x y: y3.
	c addPlot: p1.
c addPlot: p2.
c addPlot: p3.
	

	c addDecoration: (RSHorizontalTick new).
	c addDecoration: (RSVerticalTick new ).

	c open
]

{ #category : #graphs }
RTGraphs class >> reusedClassesByDate [
<script: 'self reusedClassesByDate'>
| x y z r c p |
	x := OrderedCollection new.
	y := OrderedCollection new.
	z := OrderedCollection new.
	r := Random new.
	RTPrototypeDataRepository prototypes do: [ :proto |
		x add: proto mostRecentVersionDate julianDayNumber.
		y add: (proto nbReusedClasses).
		z add: proto nbClasses.
		 ].
	c := RSChart new.
	p := RSScatterPlot new x: x y: y.
	p color: Color blue translucent.
	p processBlock: [ :shapes | 
		shapes models: z.
		RSNormalizer size
			shapes: shapes;
			from: 2;
			to: 10;
			normalize: #yourself.
		shapes translucent ].
	c addPlot: p.

	c addDecoration: (RSHorizontalTick new labelConversion: [ :val | Date julianDayNumber: val ]; useDiagonalLabel; yourself ).
	c addDecoration: RSVerticalTick new.

	c open
]

{ #category : #graphs }
RTGraphs class >> reusedComponentsByDate [
<script>
| x y z r c p |
	x := OrderedCollection new.
	y := OrderedCollection new.
	z := OrderedCollection new.
	r := Random new.
	RTPrototypeDataRepository prototypes do: [ :proto |
		x add: proto mostRecentVersionDate julianDayNumber.
		y add: proto nbReusedComponents.
		z add: (proto nbReusedClasses + proto nbReusedMethods).
		 ].
	c := RSChart new.
	p := RSScatterPlot new x: x y: y.
	p color: Color blue translucent.
	p processBlock: [ :shapes | 
		shapes models: z.
		RSNormalizer size
			shapes: shapes;
			from: 2;
			to: 7;
			normalize: #yourself.
		shapes translucent ].
	c addPlot: p.

	c addDecoration: (RSHorizontalTick new labelConversion: [ :val | Date julianDayNumber: val ]; useDiagonalLabel; yourself ).
	c addDecoration: RSVerticalTick new.

	c open
]

{ #category : #graphs }
RTGraphs class >> reusedComponentsByNbOfClasses [
<script>
| x y z r c p |
	x := OrderedCollection new.
	y := OrderedCollection new.
	z := OrderedCollection new.
	r := Random new.
	RTPrototypeDataRepository prototypes do: [ :proto |
		x add: proto nbComponents  .
		y add: proto nbReusedComponents.
		z add: (proto nbSubSystems).
		 ].
	c := RSChart new.
	p := RSScatterPlot new x: x y: y.
	p color: Color blue translucent.
	p processBlock: [ :shapes | 
		shapes models: z.
		RSNormalizer size
			shapes: shapes;
			from: 2;
			to: 7;
			normalize: #yourself.
		shapes translucent ].
	c addPlot: p.

	c addDecoration: (RSHorizontalTick new).
	c addDecoration: RSVerticalTick new.

	c open
]

{ #category : #'subsystems graphs' }
RTGraphs class >> subsystemsSizeDuringYears [
	<script>
	| subSystems chart nbSubSystems |
	subSystems := RTPrototypeDataRepository subSystems.
	nbSubSystems := subSystems size.

	"Create chart"
	chart := RSChart new.
	
	subSystems do:[ :ss | | line x y |
		"Collect subsystem size evolution"
		x := SortedCollection sortBlock:[ :a :b | a < b].
		y := OrderedCollection new.
		
		ss sourceCodeDataHistory keysAndValuesDo: [ :dateTime :sourceCodeData |
			x add: dateTime julianDayNumber.
			y add: sourceCodeData components.
		].
		
		"Create a lines for each subsystem"
		line := RSLinePlot new x: x y: y.	
		chart addPlot: line.
	].

	"Chart style"
	chart title: 'Subsystems size (in components) during years'.
	chart xlabel: 'Years' offset: 20.
	chart ylabel: 'Nb Components'.
	chart addDecoration: (RSHorizontalTick new labelConversion: [ :val | (Date julianDayNumber: val) year ]; numberOfTicks: nbSubSystems; yourself).
	chart addDecoration: (RSVerticalTick new).
	
	"Open the Chart"
	chart show.

]
