
require( '../..' );
let _ = wTools;

/* This example shows how to use bfs-based algorimths on graph */

// declaring nodes and relations

var a = { name : 'a', nodes : [] } // 1
var b = { name : 'b', nodes : [] } // 2
var c = { name : 'c', nodes : [] } // 3
var d = { name : 'd', nodes : [] } // 4

a.nodes.push( b,c );
c.nodes.push( d );

// making a graph

var sys = new _.graph.AbstractGraphSystem(); // make container for groups( graphs )
var group = sys.groupMake(); // create graph( empty group of nodes )
group.nodesAdd([ a,b,c,d ]); // add nodes to the group

// getting nodes that can be reached from provided node

var layers = group.lookBfs({ nodes : a }); // in this case we are using node 'i'
console.log( '\n',layers.map( ( nodes ) => group.nodesToNames( nodes ) ) )

/*
 [ [ 'a' ], [ 'b', 'c' ], [ 'd' ] ]
*/






