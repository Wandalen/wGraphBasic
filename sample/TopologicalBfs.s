require( 'wgraphbasic' );
let _ = wTools;

/*
This example shows how to use topological sort ( based on BFS ) on directed graph, possibly cycled.
*/

/* define a graph of arbitrary structure */

var a = { name : 'a', nodes : [] }; // 1
var b = { name : 'b', nodes : [] }; // 2
var c = { name : 'c', nodes : [] }; // 3
var d = { name : 'd', nodes : [] }; // 4

a.nodes.push( b, c );
c.nodes.push( d );

/* declare the graph */

var sys = new _.graph.AbstractGraphSystem(); // declare sysyem of graphs
var group = sys.nodesGroup(); // declare group of nodes

/* topological sort based on depth first search */

var ordering = group.topSortLeastDegreeBfs([ a, b, c, d ]);
ordering = ordering.map( ( nodes ) => group.nodesToNames( nodes ) ); // get names of nodes to simplify output
console.log( ordering );

/* [ 'a', 'b', 'c', 'd' ] */
