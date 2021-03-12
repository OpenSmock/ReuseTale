Class {
	#name : #RTGraphs,
	#superclass : #Object,
	#category : #'ReuseTale-model'
}

{ #category : #'custom shape - experimental' }
RTGraphs class >> ELPRsBox [
| tmp |
tmp := RSBox newAnonymousSubclass.
tmp compile: 'radius: aValue
	^ self extent: 5 @ 5'.
^tmp
]

{ #category : #'A Graph' }
RTGraphs class >> averageLatexTable [

	<script>
	| datas stream averageNewComponentsPerPrototypes averageReusedComponentsPerPrototypes averageNewClassesPerPrototypes averageReusedClassesPerPrototypes averageComponentsPerPrototypes averageClassesPerPrototypes |
	
	datas := RTPrototypeDataRepository getPrototypesFromOlderToMostRecent.
	
	averageNewComponentsPerPrototypes := (datas collect:[:p| p nbNewComponents]) average.
	averageReusedComponentsPerPrototypes := (datas collect:[:p| p nbReusedComponents]) average.
	averageNewClassesPerPrototypes := (datas collect:[:p| p nbNewClasses]) average.
	averageReusedClassesPerPrototypes := (datas collect:[:p| p nbReusedClasses]) average.
	averageComponentsPerPrototypes := (datas collect:[:p| p nbTotalComponents]) average.	
	averageClassesPerPrototypes := (datas collect:[:p| p nbTotalClasses]) average.	
	
	stream := WriteStream on: String new.
	stream << self openAverageLatexTable.
	stream << 'Average new code & '.
	stream << (averageNewComponentsPerPrototypes asFloat roundUpTo: 0.01) printString.
	stream << ' ('.
	stream << ((averageNewComponentsPerPrototypes/averageComponentsPerPrototypes) asFloat roundUpTo: 0.01) printString.
	stream << '\%) & '.
	
	stream << (averageNewClassesPerPrototypes asFloat roundUpTo: 0.01) printString.	
	stream << ' ('.
	stream << ((averageNewClassesPerPrototypes/averageClassesPerPrototypes) asFloat roundUpTo: 0.01) printString.
	stream << '\%)\\'.
	stream cr.
	
	stream << 'Average reused code & '.
	stream << (averageReusedComponentsPerPrototypes asFloat roundUpTo: 0.01) printString.
	stream << ' ('.
	stream << ((averageReusedComponentsPerPrototypes/averageComponentsPerPrototypes) asFloat roundUpTo: 0.01) printString.
	stream << '\%) & '.
	stream << (averageReusedClassesPerPrototypes asFloat roundUpTo: 0.01) printString.
	stream << ' ('.
	stream << ((averageReusedClassesPerPrototypes/averageClassesPerPrototypes) asFloat roundUpTo: 0.01) printString.
	stream << '\%)\\'.
	stream cr.
	
	stream << 'Average code & '.
	stream << (averageComponentsPerPrototypes asFloat roundUpTo: 0.01) printString.
	stream << ' & '.
	stream << (averageClassesPerPrototypes asFloat roundUpTo: 0.01) printString.

	stream << self closeAverageLatexTable.
	stream contents inspect
]

{ #category : #'B Graph' }
RTGraphs class >> classesEvolutionBySubsystems [
<script>
| x y y2 datas previous c p canvas p2 lb set colors plots data dataSource |

	c := RSChart new.
	
	datas := RTPrototypeDataRepository subSystemsSortedByName.
	colors := Color wheel: datas size.
	plots := OrderedCollection new.
	1 to: datas size do: [ :index |
		x := OrderedCollection new.
		y := OrderedCollection new.
		data := datas at: index.
		dataSource := data sourceCodeDataHistory associations asSortedCollection:[:a :b | a key julianDayNumber < b key julianDayNumber ].
		dataSource do: [ :e |
			x add: e key julianDayNumber.
			y add: e value classes.
		].
		p := RSLinePlot new.
		p x: x y: y.
		p color: (colors at:index).
		c addPlot: p.
		plots add: (colors at:index)->((datas at: index) name->p).
		 ].
	

	c addDecoration: (RSHorizontalTick new labelConversion: [ :val | Date julianDayNumber: val ]; useDiagonalLabel; numberOfTicks: 15; yourself ).
	c addDecoration: (RSVerticalTick new ).
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
	c chartExtents extent: 400@((400*9)/16).
	c container: canvas.
	
	lb := RSLegend new.
	lb container: c canvas.
	plots do: [ :plt |
		lb text: plt value key withBoxColor: plt key.
	].
	lb legendDo: [ :shape | shape withBorder; padding: 10; scaleBy: 0.5 ].
	lb location 
		inner; bottom; right; offset: -25.
	lb build.
	
	c ylabel: 'Nb. of classes'.
	c xlabel: 'Time'.
	
	c open
]

{ #category : #'A Graph' }
RTGraphs class >> closeAverageLatexTable [
	^'
\end{tabular}
\caption{Average code (components and classes) per prototype over 15 years (computed from Table~\ref{table:component-reuse}). 
Values are rounded to hundredths.}
\label{table:component-reuse-average}
\end{table}
'
]

{ #category : #'A Graph' }
RTGraphs class >> closeFullStatisticsLatexTable [
	^'
\end{tabular}
\caption{24 prototypes (\textit{Pty}) built from 2007 to 2021.
For each prototype, 
the first line shows the number of subsystems (\textit{Ssy}) used by the prototype, and the number of new components and new classes specifically developed for that prototype.
The second line shows the years during which the prototype was (or is) maintained, then the number of reused components and classes for that prototype.
Reused components and classes come from the subsystems used to build the prototype.}
\label{table:component-reuse}
\end{table}
'
]

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

{ #category : #'B Graph' }
RTGraphs class >> componentEvolutionBySubsystems [

	<script>
	| x y y2 datas previous c p canvas p2 lb set colors plots data dataSource manualTicks |
	c := RSChart new.

	datas := RTPrototypeDataRepository subSystemsSortedByName.
	colors := Color wheel: datas size.
	plots := OrderedCollection new.
	1 to: datas size do: [ :index | 
		x := OrderedCollection new.
		y := OrderedCollection new.
		data := datas at: index.
		dataSource := data sourceCodeDataHistory associations 
			              asSortedCollection: [ :a :b | 
			              a key julianDayNumber < b key julianDayNumber ].
		dataSource do: [ :e | 
			x add: e key julianDayNumber.
			y add: e value components ].
		p := RSLinePlot new.
		p x: x y: y.
		p color: (colors at: index).
		c addPlot: p.
		plots add: (colors at: index) -> ((datas at: index) idWithName -> p) ].


	manualTicks := RSManualHorizontalTick new
		               labelConversion: [ :val | 
			               (Date julianDayNumber: val) year ];
		               useDiagonalLabel;
		               numberOfTicks: 11;
		               useNiceLabel;
		               yourself.
	2010 to: 2021 do: [ :yr | 
		manualTicks addValue: (Date year: yr day: 1) julianDayNumber
		"c addDecoration: (RSXMarkerDecoration new value: ((Date year: yr day: 1 ) julianDayNumber) )." ].
	"manualTicks addValue: (Date year: 2015 month: 6 day: 15) julianDayNumber."
	c addDecoration: manualTicks.
	c addDecoration: RSVerticalTick new.

	canvas := RSCanvas new.
	"canvas @ RSCanvasController."
	c chartExtents extent: 400 @ (400 * 9 / 16).

	c container: canvas.

	lb := RSLegend new.
	lb container: c canvas.
	plots do: [ :plt | lb text: plt value key withBoxColor: plt key ].
	lb legendDo: [ :shape | 
		shape
			withBorder;
			padding: 10;
			scaleBy: 0.5 ].
	lb location
		inner;
		bottom;
		right;
		offset: -25.
	lb build.

	c ylabel: 'Nb. of components'.
	c xlabel: 'Years'.
	canvas @ RSDraggableCanvas.
	canvas @ RSZoomableCanvas.

	c open.

	RSPDFExporter new
		zoomToShapes;
		canvas: canvas;
		exportToFile: 'Fig8.pdf' asFileReference
]

{ #category : #'B Graph' }
RTGraphs class >> componentEvolutionBySubsystems2 [
<script>
| x y y2 datas previous c p canvas p2 lb set colors plots data dataSource |

	c := RSChart new.
	
	datas := RTPrototypeDataRepository subSystemsSortedByName.
	colors := Color wheel: datas size.
	plots := OrderedCollection new.
	1 to: datas size do: [ :index |
		x := OrderedCollection new.
		y := OrderedCollection new.
		data := datas at: index.
		dataSource := data sourceCodeDataHistory associations asSortedCollection:[:a :b | a key julianDayNumber < b key julianDayNumber ].
		dataSource do: [ :e |
			x add: e key julianDayNumber.
			y add: e value classes.
		].
		p := RSLinePlot new.
		p x: x y: y.
		p color: (colors at:index).
		c addPlot: p.
		plots add: (colors at:index)->((datas at: index) name->p).
		 ].
	

	c addDecoration: (RSHorizontalTick new labelConversion: [ :val | Date julianDayNumber: val ]; useDiagonalLabel; numberOfTicks: 20; useNiceLabel; yourself ).
	c addDecoration: (RSVerticalTick new ).
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
	c chartExtents extent: 400@((400*9)/16).
	c container: canvas.
	
	lb := RSLegend new.
	lb container: c canvas.
	plots do: [ :plt |
		lb text: plt value key withBoxColor: plt key.
	].
	lb legendDo: [ :shape | shape withBorder; padding: 10; scaleBy: 0.5 ].
	lb location 
		inner; bottom; right; offset: -25.
	lb build.
	
	c ylabel: 'Nb. of classes'.
	c xlabel: 'Time'.
	
	c open
]

{ #category : #'B Graph' }
RTGraphs class >> componentEvolutionBySubsystems3 [
<script>
| x y y2 datas previous c p canvas p2 lb set colors plots data dataSource |

	c := RSChart new.
	
	datas := RTPrototypeDataRepository subSystemsSortedByName.
	colors := Color wheel: datas size.
	plots := OrderedCollection new.
	1 to: datas size do: [ :index |
		x := OrderedCollection new.
		y := OrderedCollection new.
		data := datas at: index.
		dataSource := data sourceCodeDataHistory associations asSortedCollection:[:a :b | a key julianDayNumber < b key julianDayNumber ].
		dataSource do: [ :e |
			x add: e key julianDayNumber.
			y add: e value classes.
		].
		p := RSLinePlot new.
		p x: x y: y.
		p color: (colors at:index).
		c addPlot: p.
		plots add: (colors at:index)->((datas at: index) name->p).
		 ].
	

	c addDecoration: (RSHorizontalTick new useDiagonalLabel; numberOfTicks: 50; integer; doNotUseNiceLabel ; yourself ).
	c addDecoration: (RSVerticalTick new ).
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
	c chartExtents extent: 400@((400*9)/16).
	c container: canvas.
	
	lb := RSLegend new.
	lb container: c canvas.
	plots do: [ :plt |
		lb text: plt value key withBoxColor: plt key.
	].
	lb legendDo: [ :shape | shape withBorder; padding: 10; scaleBy: 0.5 ].
	lb location 
		inner; bottom; right; offset: -25.
	lb build.
	
	c ylabel: 'Nb. of classes'.
	c xlabel: 'Time'.
	
	c open
]

{ #category : #'B Graph' }
RTGraphs class >> componentEvolutionBySubsystems4 [
<script>
| x y y2 datas previous c p canvas p2 lb set colors plots data dataSource |

	c := RSChart new.
	
	datas := RTPrototypeDataRepository subSystemsSortedByName.
	colors := Color wheel: datas size.
	plots := OrderedCollection new.
	1 to: datas size do: [ :index |
		x := OrderedCollection new.
		y := OrderedCollection new.
		data := datas at: index.
		dataSource := data sourceCodeDataHistory associations asSortedCollection:[:a :b | a key julianDayNumber < b key julianDayNumber ].
		dataSource do: [ :e |
			x add: e key julianDayNumber.
			y add: e value classes.
		].
		p := RSLinePlot new.
		p x: x y: y.
		p color: (colors at:index).
		c addPlot: p.
		plots add: (colors at:index)->((datas at: index) name->p).
		 ].
	

	c addDecoration: (RSHorizontalTick new labelConversion: [ :val | Date julianDayNumber: val ]; useDiagonalLabel; numberOfTicks: 50; doNotUseNiceLabel ; yourself ).
	c addDecoration: (RSVerticalTick new ).
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
	c chartExtents extent: 400@((400*9)/16).
	c container: canvas.
	
	lb := RSLegend new.
	lb container: c canvas.
	plots do: [ :plt |
		lb text: plt value key withBoxColor: plt key.
	].
	lb legendDo: [ :shape | shape withBorder; padding: 10; scaleBy: 0.5 ].
	lb location 
		inner; bottom; right; offset: -25.
	lb build.
	
	c ylabel: 'Nb. of classes'.
	c xlabel: 'Time'.
	
	c open
]

{ #category : #'I Graph' }
RTGraphs class >> expertiseInPrototypes [

	<script>
	| x y datas c p canvas lb z ymin ymax xmax tmp |
	x := OrderedCollection new.
	y := OrderedCollection new.
	ymin := OrderedCollection new.
	ymax := OrderedCollection new.
	z := OrderedCollection new.
	datas := RTPrototypeDataRepository getPrototypesFromOlderToMostRecent.
	datas doWithIndex: [ :proto :index | 
		proto developers do: [ :dev | 
			x add: index.
			y add: dev.
			z add: 200 ] ].
	c := RSChart new.
	p := RSScatterPlot new
		     x: x y: y;
		     shape: self ELPRsBox new noPaint;
		     yourself.
	p color: Color blue lighter.

	xmax := x copy.
	xmax addFirst: 0.
	xmax addLast: x last + 1.
	xmax do: [ :val | 
		ymin add: 0.5.
		ymax add: 2.5 ].

	c addPlot: (RSAreaPlot new
			 x: xmax y1: ymin y2: ymax;
			 color: Color green muchLighter;
			 yourself).
	c addPlot: p.


	c addDecoration: (RSHorizontalTick new
			 integer;
			 " fromNames: (datas collect: [ :e | e name ]);"labelConversion: [ 
				 :val | 
				 tmp := datas at: val ifAbsent: [ nil ].
				 tmp ifNil: [ '' ] ];
			 numberOfTicks: datas size + 2;
			 useDiagonalLabel;
			 yourself).
	c addDecoration: (RSVerticalTick new
			 numberOfTicks: 12;
			 yourself).
	c maxValueY: 15.
	c padding: 10 @ 0.

	canvas := RSCanvas new.
"	canvas @ RSCanvasController."
	c chartExtents extent: 400 @ (400 * 9 / 16).
	c container: canvas.

	lb := RSLegend new.
	lb container: c canvas.
	lb text: 'Expertise' withBoxColor: Color green muchLighter.
	lb text: 'Developper' withBoxColor: Color blue.
	lb legendDo: [ :shape | 
		shape
			withBorder;
			padding: 10;
			scaleBy: 0.5 ].
	lb location offset: 200 @ 40.
	lb build.

	c ylabel: 'Developper ID'.

	c open.
	RSPDFExporter new
		zoomToShapes;
		canvas: canvas;
		exportToFile: 'Fig13.pdf' asFileReference

]

{ #category : #'B Graph' }
RTGraphs class >> methodEvolutionBySubsystems [
<script>
| x y y2 datas previous c p canvas p2 lb set colors plots data dataSource |

	c := RSChart new.
	
	datas := RTPrototypeDataRepository subSystemsSortedByName.
	colors := Color wheel: datas size.
	plots := OrderedCollection new.
	1 to: datas size do: [ :index |
		x := OrderedCollection new.
		y := OrderedCollection new.
		data := datas at: index.
		dataSource := data sourceCodeDataHistory associations asSortedCollection:[:a :b | a key julianDayNumber < b key julianDayNumber ].
		dataSource do: [ :e |
			x add: e key julianDayNumber.
			y add: e value methods.
		].
		p := RSLinePlot new.
		p x: x y: y.
		p color: (colors at:index).
		c addPlot: p.
		plots add: (colors at:index)->((datas at: index) name->p).
		 ].
	

	c addDecoration: (RSHorizontalTick new labelConversion: [ :val | Date julianDayNumber: val ]; useDiagonalLabel; numberOfTicks: 15; yourself ).
	c addDecoration: (RSVerticalTick new ).
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
	c chartExtents extent: 400@((400*9)/16).
	c container: canvas.
	
	lb := RSLegend new.
	lb container: c canvas.
	plots do: [ :plt |
		lb text: plt value key withBoxColor: plt key.
	].
	lb legendDo: [ :shape | shape withBorder; padding: 10; scaleBy: 0.5 ].
	lb location 
		inner; bottom; right; offset: -25.
	lb build.
	
	c ylabel: 'Nb. of methods'.
	c xlabel: 'Time'.
	
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

{ #category : #'A Graph' }
RTGraphs class >> openAverageLatexTable [
	^'
\begin{table}[]
\centering
\begin{tabular}{lll}
	 &
	\textit{Components} &	
	\textit{Classes}\\
'
]

{ #category : #'A Graph' }
RTGraphs class >> openFullStatisticsLatexTable [
	^'
\definecolor{Gray}{gray}{0.9}
\begin{table}[]
\centering
\begin{tabular}{p{1cm}p{0.1cm}ll}
	\textit{Pty.} &
	\textit{Ssy.} &
	\textit{Components} &	
	\textit{Classes}\\
'
]

{ #category : #'A Graph' }
RTGraphs class >> overallLatexTable [

	<script>
	| datas stream counter |
	datas := RTPrototypeDataRepository getPrototypesFromOlderToMostRecent.
	stream := WriteStream on: String new.
	stream << self openFullStatisticsLatexTable.

	counter := 0.
	datas do: [ :prototype | 
		stream cr.
		stream << (prototype
			 fullStatisticsLatexLineColoredAs: (counter even
					  ifTrue: [ 'Gray' ]
					  ifFalse: [ nil ])
			 counter: counter + 1).
		counter := counter + 1 ].

	stream << self closeFullStatisticsLatexTable.
	stream contents inspect
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

{ #category : #'D Graph' }
RTGraphs class >> reuseLevelByYearSpecificCanvas [

	<script>
	| x y r c nb p datas y2 nb2 canvas manualTicks lb |
	x := OrderedCollection new.
	y := OrderedCollection new.
	y2 := OrderedCollection new.
	r := Random new.
	datas := RTPrototypeDataRepository getPrototypesByYear associations 
		         asSortedCollection: [ :a :b | a key < b key ].

	datas do: [ :dataList | 
		dataList value size = 0 ifFalse: [ 
			nb := 0.
			nb2 := 0.
			x add: dataList key.
			dataList value do: [ :proto | 
				nb := nb + proto nbReusedComponents.
				nb2 := nb2 + proto nbTotalComponents ].

			y add: nb / nb2 * 100 ] ].
	c := RSChart new.
	p := RSLinePlot new x: x y: y.
	p color: Color blue.
	c addPlot: p.

	manualTicks := RSManualHorizontalTick new
		               useDiagonalLabel;
		               numberOfTicks: 11;
		               useNiceLabel;
		               yourself.
	2010 to: 2021 do: [ :yr | manualTicks addValue: yr ].
	"c addDecoration: (RSXMarkerDecoration new value: ((Date year: yr day: 1 ) julianDayNumber) )."
	"manualTicks addValue: (Date year: 2015 month: 6 day: 15) julianDayNumber."
	c addDecoration: manualTicks.
	c addDecoration: RSVerticalTick new.

	canvas := RSCanvas new.
	canvas @ RSZoomableCanvas.
	canvas @ RSDraggableCanvas.

	c chartExtents extent: 200 @ 112.
	c container: canvas.

	lb := RSLegend new.
	lb container: canvas.
	lb text: '% of reused components' withBoxColor: p computeColor.
	lb legendDo: [ :shape | 
		shape
			withBorder;
			padding: 10;
			scaleBy: 0.5 ].
	lb location
		bottom;
		center;
		offset: 80 @ 30.
	lb build.

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

{ #category : #'A Graph' }
RTGraphs class >> reuseSubsystemsByPrototypes [
<script>
| x y y2 datas previous c p canvas p2 lb set |
	x := OrderedCollection new.
	y := OrderedCollection new.
	y2 := OrderedCollection new.
	
	datas := RTPrototypeDataRepository getPrototypesFromOlderToMostRecent.
	previous := nil.
	1 to: datas size do: [ :index |
		x add: index.
		"previous isNil ifFalse:[ y add: ((datas at: index) subSystems select:[:e | previous subSystems includes: e]) size] ifTrue:[ y add: 0]."
		set := Set new.
		1 to: index-1 do: [:i | set addAll: (datas at: i) subSystems ].
		y add: ((datas at: index) subSystems select:[:e | set includes: e]) size.
		y2 add: (datas at: index) subSystems size.
		previous := datas at: index. 
		 ].
	c := RSChart new.
	p := RSBarPlot  new x: x y: y2.
	p color: Color blue lighter.
	c addPlot: p.
	p2 := RSBarPlot  new x: x y: y.
	p2 color: (Color blue muchDarker).
	c addPlot: p2.

	c addDecoration: (RSHorizontalTick new fromNames: (datas collect: [:e | e name]); useDiagonalLabel ; yourself).
	c addDecoration: (RSVerticalTick new ).
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
	c chartExtents extent: 400@((400*9)/16).
	c container: canvas.
	
	lb := RSLegend new.
	lb container: c canvas.
	lb text: 'Nb. Subsystems' withBoxColor: p computeColor.
	lb text: 'Reused Subsystems' withBoxColor: p2 computeColor.
	lb legendDo: [ :shape | shape withBorder; padding: 10; scaleBy: 0.5 ].
	lb location 
		inner; bottom; right; offset: -10.
	lb build.
	
	c open
]

{ #category : #'C Graph' }
RTGraphs class >> reuseTacticalSubsystemInPrototypes [

	<script>
	| x y y2 datas previous c p canvas p2 lb set |
	x := OrderedCollection new.
	y := OrderedCollection new.

	datas := RTPrototypeDataRepository getPrototypesFromOlderToMostRecent.
	previous := nil.
	1 to: datas size do: [ :index | 
		x add: index.
		"previous isNil ifFalse:[ y add: ((datas at: index) subSystems select:[:e | previous subSystems includes: e]) size] ifTrue:[ y add: 0]."
		set := Set new.
		1 to: index - 1 do: [ :i | set addAll: (datas at: i) subSystems ].
		y add: (((datas at: index) subSystems
				  detect: [ :e | e name = 'Subsystem 5' ]
				  ifNone: [ nil ]) ifNil: [ 0 ] ifNotNil: [ 1 ]).
		previous := datas at: index ].
	c := RSChart new.
	p := RSBarPlot new x: x y: y.
	p color: Color blue.
	c addPlot: p.
	c maxValueY: 1.

	c addDecoration: (RSHorizontalTick new
			 fromNames: (datas collect: [ :e | e name ]);
			 useDiagonalLabel;
			 yourself).
	c addDecoration: (RSVerticalTick new
			 integer;
			 numberOfTicks: 2;
			 yourself).
	canvas := RSCanvas new.
	"canvas @ RSCanvasController."
	c chartExtents extent: 400 @ (400 * 9 / 16).
	c container: canvas.
	c xlabel: 'Tactical View reuse in prototypes'.
	canvas @ RSDraggableCanvas.
	canvas @ RSZoomableCanvas.

	c open.

	"RSPDFExporter new
		zoomToShapes;
		canvas: canvas;
		exportToFile: 'Fig9.pdf' asFileReference"
]

{ #category : #'C Graph' }
RTGraphs class >> reuseTacticalSubsystemInPrototypesPie [

	<script>
	| x y y2 datas previous c p canvas p2 lb set i val l |
	x := OrderedCollection new.
	x add: 'With Tactical View' -> 0.
	x add: 'Without Tactical View' -> 0.


	datas := RTPrototypeDataRepository getPrototypesFromOlderToMostRecent.
	previous := nil.
	1 to: datas size do: [ :index | 
		val := (datas at: index) subSystems
			       detect: [ :e | e name = 'Subsystem 5' ]
			       ifNone: [ nil ].
		val isNil
			ifTrue: [ x last value: x last value + 1 ]
			ifFalse: [ x first value: x first value + 1 ] ].

	p := RSPie new
		     objects: x;
		     slice: [ :m | m value ];
		     yourself.

	p
		sliceColor: NSScale category10;
		build.
	p shapes
		select: [ :s | s model value > 5 ]
		thenDo: [ :s | s emphasizeWith: 20 ].



	canvas := p canvas.

	lb := RSLegend new.
	lb container: canvas.
	lb text: 'With Tactical View' withBoxColor: p shapes first color.
	lb text: 'Without Tactical View' withBoxColor: p shapes last color.
	lb legendDo: [ :shape | 
		shape
			withBorder;
			padding: 10;
			scaleBy: 0.5 ].
	lb location
		inner;
		bottom;
		offset: 0 @ 30.
	lb build.

	"canvas @ RSCanvasController."
		canvas zoomToFit.
	canvas @ RSDraggableCanvas.
	canvas @ RSZoomableCanvas.

	canvas open.

	RSPDFExporter new
		zoomToShapes;
		canvas: canvas;
		exportToFile: 'Fig9.pdf' asFileReference
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

{ #category : #'F Graph' }
RTGraphs class >> subsystemsAndComponentsNumberInTime [
<script>
| x y  datas  c p canvas   data y2 p2 lb datas2 comps decoplot paint manualTicks previous |
	x := OrderedCollection new.
	y := OrderedCollection new.
	y2 := OrderedCollection new.
	datas := RTPrototypeDataRepository getSubSystemsByYear.
	datas keys asSortedCollection last+1 to: 2021 do: [ :i | datas at: i put: Array new ].
	previous := 0.
	datas associations do: [ :asso |
		x add: (Date year: asso key day: 1) julianDayNumber.
		(asso value size = 0) ifFalse: [previous := asso value size + previous. y add: previous.] ifTrue:[
		y add: previous.
		 ]].
	datas2 := RTPrototypeDataRepository subSystemsSortedByName.
	datas2 do: [ :syst | 
		comps := syst componentsNumberByYearFrom: datas keys asSortedCollection first to:  datas keys asSortedCollection last.
			y2 isEmpty ifTrue:[ comps associations do: [  :a | y2 add: a value ]] ifFalse:[
			comps associations doWithIndex:  [ :a :index | y2 at: index put: ((y2 at: index)+a value) ]]
		 ].
	
	c := RSChart new.
	p := RSBarPlot  new x: x y: y2; yourself .
	p color: Color purple muchDarker .
	c addPlot: p.
	p2 := RSBarPlot  new x: x y: y*10; yourself .
	p2 color: Color blue darker .
	c addPlot: p2.

	"p := RSLinePlot   new x: x y: y2; fmt: 'o'; yourself ."


"	decoplot := RSAreaPlot new x: x y1: y2 y2: 50.
	paint := LinearGradientPaint fromArray: 
		{0-> (Color purple muchDarker alpha: 0.3).
		0.8 -> Color transparent}.
	paint start: 0@ -100; stop: 0@ 100.
	decoplot shape paint: paint.
	c addPlot: decoplot."

	"c addDecoration: (RSHorizontalTick new fromNames: (datas collect: [:e | e name]); useDiagonalLabel ; yourself)."
	manualTicks := RSManualHorizontalTick new labelConversion: [ :val | (Date julianDayNumber: val) year]; useDiagonalLabel; numberOfTicks: 11 ; yourself.
	2007 to: 2021 do: [ :yr |
		manualTicks addValue: (Date year: yr day: 1 ) julianDayNumber.
	].
	c addDecoration: manualTicks.
	c addDecoration: (RSVerticalTick new integer; numberOfTicks: 3; yourself ).
	canvas := RSCanvas new.
"	canvas @ RSCanvasController."
	c chartExtents extent: 400@((400*9)/16).
	c container: canvas.
"	c xlabel: 'Subsystems and components in time'."
	
	lb := RSLegend new.
	lb container: c canvas.
	lb text: 'Number of components' withBoxColor: p computeColor.
	lb text: 'Number of subsystems' withBoxColor: p2 computeColor.
	lb legendDo: [ :shape | shape withBorder; padding: 10; scaleBy: 0.5 ].
	lb location offset: 200@40.
	lb build.
	
	c open.
	RSPDFExporter new
		zoomToShapes;
		canvas: canvas;
		exportToFile: 'Fig12.pdf' asFileReference

]

{ #category : #'subsystems graphs' }
RTGraphs class >> subsystemsSizeDuringYears [
	<script>
	| subSystems chart nbSubSystems ssKeys |
	subSystems := RTPrototypeDataRepository subSystems.
	nbSubSystems := subSystems size.

	"Create chart"
	chart := RSChart new.
	
	subSystems do:[ :ss | | line x y |
		"Collect subsystem size evolution"
		x := SortedCollection sortBlock:[ :a :b | a < b].
		y := OrderedCollection new.
		ssKeys := ss sourceCodeDataHistory keys  sort: [ :a :b| a < b  ].
		ssKeys do: [ :dateTime |
			|sourceCodeData|
			sourceCodeData := ss sourceCodeDataHistory at: dateTime.
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

{ #category : #'E Graph' }
RTGraphs class >> tacticalSubsystemChangesInTime [
<script>
| x y y2 datas previous c p canvas p2 lb set manualTicks decoplot color paint |
	x := OrderedCollection new.
	y := OrderedCollection new.

	datas := (RTPrototypeDataRepository subSystems at: 'Subsystem 5') sourceCodeDataHistory associations asSortedCollection:[:a :b | a key < b key].
	previous := nil.
	1 to: datas size do: [ :index |
		x add: (datas at: index) key julianDayNumber.
		y add: (datas at: index) value components
	].
	c := RSChart new.
	p := RSLinePlot   new x: x y: y; fmt: 'o'; yourself .
	p color: Color blue lighter.
	c addPlot: p.

	decoplot := RSAreaPlot new x: x y1: y y2: 50.
	paint := LinearGradientPaint fromArray: 
		{0-> (Color blue lighter alpha: 0.3).
		0.8 -> Color transparent}.
	paint start: 0@ -100; stop: 0@ 100.
	decoplot shape paint: paint.
	c addPlot: decoplot.

	"c addDecoration: (RSHorizontalTick new fromNames: (datas collect: [:e | e name]); useDiagonalLabel ; yourself)."
	manualTicks := RSManualHorizontalTick new labelConversion: [ :val | (Date julianDayNumber: val) year]; useDiagonalLabel; numberOfTicks: 11 ; yourself.
	2010 to: 2021 do: [ :yr |
		manualTicks addValue: (Date year: yr day: 1 ) julianDayNumber.
	].
	c addDecoration: manualTicks.
	c addDecoration: (RSVerticalTick new integer; numberOfTicks: 3; yourself ).
	canvas := RSCanvas new.
	"canvas @ RSCanvasController."
	c chartExtents extent: 400@((400*9)/16).
	c container: canvas.
	c xlabel: 'Tactical View number of components in time'.
	
	c open.
	
RSPDFExporter new
		zoomToShapes;
		canvas: canvas;
		exportToFile: 'Fig11.pdf' asFileReference
]

{ #category : #'D Graph' }
RTGraphs class >> timeSpentInPrototypes [

	<script>
	| x y datas c p canvas data y2 p2 lb |
	x := OrderedCollection new.
	y := OrderedCollection new.
	y2 := OrderedCollection new.
	datas := RTPrototypeDataRepository getPrototypesFromOlderToMostRecent.
	1 to: datas size do: [ :index | 
		x add: index.
		"previous isNil ifFalse:[ y add: ((datas at: index) subSystems select:[:e | previous subSystems includes: e]) size] ifTrue:[ y add: 0]."
		data := datas at: index.
		y add: (data mostRecentVersionDate julianDayNumber
			 - data firstVersionDate julianDayNumber / data developers size
			 / (data publications ifNil: [ 1 ])) asFloat.
		y2 add: data developers size ].
	c := RSChart new.
	p := RSBarPlot new x: x y: y.
	p2 := RSLinePlot new x: x y: y2.
	p2 color: Color red muchDarker.
	p color: Color green muchDarker.
	c addPlot: p.
	c addPlot: p2.

	c addDecoration: (RSHorizontalTick new
			 fromNames: (datas collect: [ :e | e name ]);
			 useDiagonalLabel;
			 yourself).
	c addDecoration: RSVerticalTick new.

	canvas := RSCanvas new.
	"canvas @ RSCanvasController."
	c chartExtents extent: 400 @ (400 * 9 / 16).
	c container: canvas.

	lb := RSLegend new.
	lb container: c canvas.
	lb
		text: 'Days for publication by subsystems by develeopper'
		withBoxColor: p computeColor.
	lb text: 'Number of developpers' withBoxColor: p2 computeColor.
	lb legendDo: [ :shape | 
		shape
			withBorder;
			padding: 10;
			scaleBy: 0.5 ].
	lb location offset: 200 @ 40.
	lb build.

	canvas @ RSDraggableCanvas.
	canvas @ RSZoomToFitCanvas.
	canvas @ RSZoomableCanvas.
	c open.

	RSPDFExporter new
		zoomToShapes;
		canvas: canvas;
		exportToFile: 'Fig10.pdf' asFileReference
]
