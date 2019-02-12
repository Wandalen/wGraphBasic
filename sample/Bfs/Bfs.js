
require( '..' );
let _ = wTools;

/* This example shows how to use bfs-based algorimths on graph */

// declaring nodes and relations

var a = { name : 'a', nodes : [] } // 1
var b = { name : 'b', nodes : [] } // 2
var c = { name : 'c', nodes : [] } // 3
var d = { name : 'd', nodes : [] } // 4
var e = { name : 'e', nodes : [] } // 5
var f = { name : 'f', nodes : [] } // 6
var g = { name : 'g', nodes : [] } // 7
var h = { name : 'h', nodes : [] } // 8
var i = { name : 'i', nodes : [] } // 9
var j = { name : 'j', nodes : [] } // 10

a.nodes.push( b ); // 1
b.nodes.push( e, f ); // 2
c.nodes.push( b ); // 3
d.nodes.push( a, g ); // 4
e.nodes.push( a, c, h ); // 5
f.nodes.push(); // 6
g.nodes.push( h ); // 7
h.nodes.push( i ); // 8
i.nodes.push( f, h ); // 9
j.nodes.push(); // 10

// making a graph

var sys = new _.graph.AbstractGraphSystem();
var group = sys.groupMake(); // create graph container
group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]); // add nodes to the container
logger.log( group.nodesExportInfo() );// print information about nodes relation

/*
1 : 2
2 : 5 6
3 : 2
4 : 1 7
5 : 1 3 8
6 :
7 : 8
8 : 9
9 : 6 8
10 :
*/

// getting "Topological" order of graph nodes where all edges are pointing in same direction

console.log( 'Topological order using bfs algorithm:' )
var ordering = group.topologicalSortSourceBasedBfs();
ordering = ordering.map( ( nodes ) => group.nodesToNames( nodes ) ); // get names of nodes to simplify output
console.log( 'Ordering:\n', ordering );

/*
[
  [ 'd', 'j' ],
  [ 'a', 'g' ],
  [ 'b', 'h' ],
  [ 'e', 'f', 'i' ],
  [ 'c' ]
]
*/

// getting nodes that can be reached from provided node

var layers = group.lookBfs({ nodes : i }); // in this case we are using node 'i'
console.log( '\n',layers.map( ( nodes ) => group.nodesToNames( nodes ) ) )

/*
  [ [ 'i' ], [ 'f', 'h' ] ]
*/






