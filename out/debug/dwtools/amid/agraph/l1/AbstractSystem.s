( function _AbstractSystem_s_( ) {

'use strict';

/*

Graph :: set of nodes and set of edges or arcs connecting some or all nodes.
Incident edges :: of the node, are edges connected to the node.
Connected nodes :: nodes are connected if them have edge connecting both of them.
Reachable node :: node v is reachable from u if there is a path from v to u.
DFS :: depth-first search.
BFS :: breadth-first search.
DAG :: directed acycled graph.
SCC :: Strongly connected components.
Node degree :: total number of incoming and outgoint edges of the node.
Indegree :: of the node is number of incoming edges.
Outdegree :: of the node is number of outgoing edges.
Sink node :: node with zero outdegree.
Source node :: node with zero indegree.
Universal node :: node connected to all nodes of the graph.
Terminal node :: pendant node :: leaf node :: node with degree of one.
Neighborhood :: is an enduced subgraph of the graph, formed by all nodes adjacent to v.
Neigbour nodes :: nodes which are connected to the node.
Low-link value of a node :: smallest node id reachable from the node.
Topological ordering :: linear ordered DAG.
Topological sort :: algorithm of linear ordering of DAG.
Distance between nodes :: minimal number of edges to get from one given node to another given node.
Distance layers :: array of arrays of nodes. First layer has origin or zero-distance set of nodes. Second layer has nodes on distance one from origin. And os on.

*/

let _ = _global_.wTools;
let Parent = null;
let Self = function wAbstractGraphSystem( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'AbstractGraphSystem';

// --
// routine
// --

function init( o )
{
  let sys = this;

  _.instanceInit( sys );
  Object.preventExtensions( sys );

  if( o )
  sys.copy( o );

  return sys;
}

//

function finit()
{
  let sys = this;
  _.Copyable.prototype.finit.call( sys );
}

//

function groupMake( o )
{
  let sys = this;
  _.assert( arguments.length === 0 || arguments.length === 1 );
  o = o || Object.create( null );
  if( !o.sys )
  o.sys = sys;
  return sys.Group( o );
}

//

function idIs( id )
{
  let sys = this;
  if( !_.numberIs( id ) )
  return false;
  if( !( id >= 0 ) )
  return false;
  if( id > sys.nodeCounter )
  return false;
  return true;
}

//

function nodeHas( nodeHandle )
{
  let sys = this;
  _.assert( !!nodeHandle );
  return sys.nodeToIdHash.has( nodeHandle );
}

//

function nodeToIdTry( nodeHandle )
{
  let sys = this;
  let id = sys.nodeToIdHash.get( nodeHandle );
  return id;
}

//

function nodeToId( nodeHandle )
{
  let sys = this;
  let id = sys.nodeToIdHash.get( nodeHandle );
  _.assert( sys.idIs( id ), 'Id for nodeHandle was not found' );
  return id;
}

//

function idToNodesTry( nodeId )
{
  let sys = this;
  let nodeHandle = sys.idToNodeHash.get( nodeId );
  return nodeHandle;
}

//

function idToNodes( nodeId )
{
  let sys = this;
  let nodeHandle = sys.idToNodeHash.get( nodeId );
  _.assert( !!nodeHandle, 'Id for the node was not found' );
  return nodeHandle;
}

//

function nodeDescriptorGet( nodeId )
{
  let sys = this;

  _.assert( arguments.length === 1 );

  if( !sys.idIs( nodeId ) )
  nodeId = sys.nodeToId( nodeId );

  let descriptor = sys.nodeDescriptorsHash.get( nodeId );

  return descriptor;
}

//

function nodeDescriptorProduce( nodeId )
{
  let sys = this;

  _.assert( arguments.length === 1 );

  if( !sys.idIs( nodeId ) )
  nodeId = sys.nodeToId( nodeId );

  debugger;
  let descriptor = sys.nodeDescriptorsHash.get( nodeId );
  debugger;

  _.assert( 'not tested' );

  if( descriptor === undefined )
  {
    descriptor = Object.create( null );
    sys.nodeDescriptorsHash.set( nodeId, descriptor );
  }

  return descriptor;
}

// --
// relations
// --

let Composes =
{
  // onNodeNeighboursGet,
}

let Aggregates =
{
}

let Associates =
{
  groups : _.define.instanceOf( Array ),
}

let Restricts =
{
  nodeCounter : 0,
  nodeToIdHash : _.define.instanceOf( Map ),
  idToNodeHash : _.define.instanceOf( Map ),
  nodeDescriptorsHash : _.define.instanceOf( Map ),
}

let Statics =
{
  Group : _.graph.AbstractGraphGroup,
}

// --
// declare
// --

let Extend =
{

  init,
  finit,

  groupMake,

  // id

  idIs,
  idsAre : _.vectorize( idIs ),
  idsAreAll : _.vectorizeAll( idIs ),
  idsAreAny : _.vectorizeAny( idIs ),
  idsAreNone : _.vectorizeNone( idIs ),

  // node

  nodeHas,
  nodesHas : _.vectorize( nodeHas ),
  nodesHasAll : _.vectorizeAll( nodeHas ),
  nodesHasAny : _.vectorizeAny( nodeHas ),
  nodesHasNone : _.vectorizeNone( nodeHas ),

  nodeToIdTry,
  nodesToIdsTry : _.vectorize( nodeToIdTry ),
  nodeToId,
  nodesToIds : _.vectorize( nodeToId ),
  idToNodesTry,
  idsToNodesTry : _.vectorize( idToNodesTry ),
  idToNodes,
  idsToNodes : _.vectorize( idToNodes ),

  nodeDescriptorGet,
  nodeDescriptorProduce,

  // relations

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extend,
});

_.Copyable.mixin( Self );

_.staticDeclare
({
  prototype : _.graph.AbstractGraphGroup.prototype,
  name : 'System',
  value : Self,
});

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;
_.graph[ Self.shortName ] = Self;

})();
