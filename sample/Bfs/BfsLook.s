
require( '../..' );
let _ = wTools;

/* This example shows how to use bfs-based algorimths on graph */

/* declaring nodes and relations */

var a = { name : 'a', nodes : [] } // 1
var b = { name : 'b', nodes : [] } // 2
var c = { name : 'c', nodes : [] } // 3
var d = { name : 'd', nodes : [] } // 4

a.nodes.push( b,c ); // add connections between node a and b,c nodes
c.nodes.push( d ); // add connection between node c and d

/* making a graph */

var sys = new _.graph.AbstractGraphSystem(); // make container for groups( graphs )
var group = sys.groupMake(); // create graph( empty group of nodes )
group.nodesAdd([ a,b,c,d ]); // add nodes to the group

/* breadth-first earch for reachable nodes using provided node as start point */

var layers = group.lookBfs({ nodes : a }); // in this case node 'a' is used
layers = layers.map( ( nodes ) => group.nodesToNames( nodes ) ) // extract name of nodes from their descriptors to simplify the output
console.log( layers )

/*
 [
   [ 'a' ],
   [ 'b', 'c' ],
   [ 'd' ]
]
*/






