
require( '..' );
let _ = wTools;

/* This example shows how to use dfs-based algorimths on directed acycled graph(DAG) */

// declaring nodes and relations

var a = { name : 'a', nodes : [] } // 1
var b = { name : 'b', nodes : [] } // 2
var c = { name : 'c', nodes : [] } // 3
var d = { name : 'd', nodes : [] } // 4
var e = { name : 'e', nodes : [] } // 5
var f = { name : 'f', nodes : [] } // 6

// setting neigbours
a.nodes.push( b, c ); // 1
b.nodes.push( d, e ); // 2
c.nodes.push(); // 3
d.nodes.push( c ); // 4
e.nodes.push( f ); // 5
f.nodes.push(); // 6

// making a graph

var sys = new _.graph.AbstractGraphSystem();
var group = sys.groupMake(); // create graph container
group.nodesAdd([ a, b, c, d, e, f ]); // add nodes to the container
logger.log( 'DAG:' )
logger.log( group.nodesExportInfo() );// print information about nodes relation

// getting "Topological" order of graph nodes where all edges are pointing in same direction

console.log( 'Topological order using dfs algorithm:' )
var ordering = group.topologicalSortDfs();
ordering = ordering.map( ( nodes ) => group.nodesToNames( nodes ) ); // get names of nodes to simplify output
console.log( "Ordering:", ordering );

// checking if nodes are connected using dfs algorithm

var connected = group.nodesAreConnectedDfs( a, d );
console.log( 'Nodes a and d are connected:', connected )

var connected = group.nodesAreConnectedDfs( c, f );
console.log( 'Nodes c and f are connected:', connected )

// getting groups of connected nodes

/*
  All 6 nodes of out graph are in single group.
  lets add two new nodes and connect them to create new group
*/

var g = { name : 'g', nodes : [] } // 7
var h = { name : 'h', nodes : [] } // 8
g.nodes.push( h ); // create relation
group.nodesAdd([ g,h ]); // add new nodes to the graph

var groups = group.groupByConnectivityDfs(); // returns array of arrays( groups ) with id's of connected nodes
console.log( 'Got: ', groups.length, 'groups of nodes' );
console.log( 'First: ', groups[ 0 ] ); // nodes from 1 to 6
console.log( 'Second: ', groups[ 1 ] ); // nodes 7 and 8




