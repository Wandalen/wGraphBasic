( function _System_s_( ) {

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

/**
 * @classdesc Class to operate system of graphs.
 * @class wAbstractGraphSystem
 * @namespace wTools.graph
 * @module Tools/mid/AbstractGraphs
 */

const _ = _global_.wTools;
let ContainerAdapter = _.containerAdapter.Abstract;
let ContainerAdapterSet = _.containerAdapter.Set;
let ContainerAdapterArray = _.containerAdapter.Array;
let Vectorize = _.routineDefaults( null, _.vectorize, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let VectorizeAll = _.routineDefaults( null, _.vectorizeAll, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let VectorizeAny = _.routineDefaults( null, _.vectorizeAny, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let VectorizeNone = _.routineDefaults( null, _.vectorizeNone, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
const Parent = null;
const Self = wAbstractGraphSystem;
function wAbstractGraphSystem( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'AbstractGraphSystem';

// --
// routine
// --

function init( o )
{
  let sys = this;

  _.workpiece.initFields( sys );
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

/**
 * @summary Makes group of nodes. Returns instance of {@link module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup wTools.graph.AbstractNodesGroup}
 * @param {Object} o Options for instance.
 * @function nodesGroup
 * @class wAbstractGraphSystem
 * @namespace wTools.graph
 * @module Tools/mid/AbstractGraphs
 */

function nodesGroup( o )
{
  let sys = this;
  _.assert( arguments.length === 0 || arguments.length === 1 );
  o = o || Object.create( null );
  if( !o.sys )
  o.sys = sys;

  _.mapSupplementNulls( o, _.mapButNulls( _.mapOnly_( null, sys, sys.FieldsForGroup ) ) );

  return sys.Group( o );
}

//

/**
 * @summary Makes group of nodes. New group does not inherit common fields. Returns instance of {@link module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup wTools.graph.AbstractNodesGroup}
 * @param {Object} o Options for instance.
 * @function nodesGroupDifferent
 * @class wAbstractGraphSystem
 * @namespace wTools.graph
 * @module Tools/mid/AbstractGraphs
 */

function nodesGroupDifferent( o )
{
  let sys = this;
  _.assert( arguments.length === 0 || arguments.length === 1 );
  o = o || Object.create( null );
  if( !o.sys )
  o.sys = sys;
  return sys.Group( o );
}

//

function nodesCollection( o )
{
  let sys = this;
  o = _.routine.options_( nodesCollection, arguments );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  if( !o.sys )
  o.sys = sys;
  if( o.group === null )
  o.group = sys.nodesGroup();
  // debugger;
  _.assert( o.group instanceof sys.Group );
  return sys.Collection( o );
}

nodesCollection.defaults =
{
  group : null,
}

// //
//
// /**
//  * @summary Returns true if entity `id` is a node id.
//  * @param {*} id Source entity
//  * @function idIs
//  * @class wAbstractGraphSystem
//  * @namespace wTools.graph
//  * @module Tools/mid/AbstractGraphs
//  */
//
// function idIs( id )
// {
//   let sys = this;
//   if( !_.numberIs( id ) )
//   return false;
//   if( !( id >= 0 ) )
//   return false;
//   if( id > sys.nodeCounter )
//   return false;
//   return true;
// }

//

/**
 * @summary Returns true system has node with descriptor `nodeHandle`.
 * @param {Object} nodeHandle Node descriptor.
 * @function hasNode
 * @throws {Error} If system doesn't have a node `nodeHandle`.
 * @class wAbstractGraphSystem
 * @namespace wTools.graph
 * @module Tools/mid/AbstractGraphs
 */

function hasNode( nodeHandle )
{
  let sys = this;
  _.assert( !!nodeHandle );
  return sys.nodeDescriptorsHash.has( nodeHandle );
}

// //
//
// /**
//  * @summary Returns id of node with descriptor `nodeHandle`.
//  * @description Doesn't throw error if can't get id of node.
//  * @param {Object} nodeHandle Node descriptor.
//  * @function nodeToIdTry
//  * @class wAbstractGraphSystem
//  * @namespace wTools.graph
//  * @module Tools/mid/AbstractGraphs
//  */
//
// function nodeToIdTry( nodeHandle )
// {
//   let sys = this;
//   let id = sys.nodeToIdHash.get( nodeHandle );
//   return id;
// }
//
// // //
//
// /**
//  * @summary Returns id of node with descriptor `nodeHandle`.
//  * @param {Object} nodeHandle Node descriptor.
//  * @function nodeToId
//  * @throws {Error} If node with descriptor `nodeHandle` doesn't exist in system.
//  * @class wAbstractGraphSystem
//  * @namespace wTools.graph
//  * @module Tools/mid/AbstractGraphs
//  */
//
// function nodeToId( nodeHandle )
// {
//   let sys = this;
//   let id = sys.nodeToIdHash.get( nodeHandle );
//   _.assert( sys.idIs( id ), 'Id for nodeHandle was not found' );
//   return id;
// }
//
// //
//
// function idToNodeTry( nodeId )
// {
//   let sys = this;
//   let nodeHandle = sys.idToNodeHash.get( nodeId );
//   return nodeHandle;
// }
//
// //
//
// function idToNode( nodeId )
// {
//   let sys = this;
//   let nodeHandle = sys.idToNodeHash.get( nodeId );
//   _.assert( !!nodeHandle, 'Id for the node was not found' );
//   return nodeHandle;
// }

//

/**
 * @summary Returns descriptor of node with id `nodeId`
 * @param {Number} nodeId Id of target node.
 * @function nodeDescriptorWithNode
 * @class wAbstractGraphSystem
 * @namespace wTools.graph
 * @module Tools/mid/AbstractGraphs
 */

function nodeDescriptorWithNode( node )
{
  let sys = this;

  _.assert( arguments.length === 1 );
  // _.assert( sys.nodeIs( node ) );

  let descriptor = sys.nodeDescriptorsHash.get( node );
  if( descriptor === undefined )
  descriptor = null;

  return descriptor;
}

//

function nodeDescriptorWith( node )
{
  let sys = this;

  _.assert( arguments.length === 1 );

  // if( !sys.idIs( nodeId ) )
  // nodeId = sys.nodeToId( nodeId );

  return sys.nodeDescriptorWithNode( node );
}

//

/**
 * @summary Returns descriptor of node with id `nodeId`. Creates new descriptor if needed.
 * @param {Number} node Node.
 * @function nodeDescriptorObtain
 * @class wAbstractGraphSystem
 * @namespace wTools.graph
 * @module Tools/mid/AbstractGraphs
 */

function nodeDescriptorObtain( node )
{
  let sys = this;

  _.assert( arguments.length === 1 );

  // if( !sys.idIs( nodeId ) )
  // nodeId = sys.nodeToId( nodeId );

  // _.assert( sys.nodeIs( node ) );

  let descriptor = sys.nodeDescriptorsHash.get( node );

  if( descriptor === undefined )
  {
    descriptor = Object.create( null );
    descriptor.count = 1;
    sys.nodeDescriptorsHash.set( node, descriptor );
  }

  return descriptor;
}

//

function nodeDescriptorDelete( node )
{
  let sys = this;

  _.assert( arguments.length === 1 );
  // _.assert( sys.nodeIs( node ) );

  let r = sys.nodeDescriptorsHash.delete( node );

  return r;
}

//

function nodeDescriptorInc( node )
{
  let sys = this;

  _.assert( arguments.length === 1 );

  let descriptor = sys.nodeDescriptorsHash.get( node );
  if( descriptor )
  descriptor.count += 1;
  else
  return sys.nodeDescriptorObtain( node );

  return descriptor;
}

//

function nodeDescriptorDec( node )
{
  let sys = this;

  _.assert( arguments.length === 1 );

  let descriptor = sys.nodeDescriptorsHash.get( node );
  if( descriptor )
  descriptor.count -= 1;

  _.assert( !!descriptor, `No node descriptor` );
  _.assert( descriptor.count >= 0, `Expects non-negative counter` );

  if( descriptor.count === 0 )
  return !sys.nodeDescriptorDelete( node )

  return true;
}

//

/**
 * @summary Check is argument allowed container either adapter of container.
 *
 * @function ContainerIs
 * @return {boolean} True if it is such thing.
 * @class wAbstractGraphSystem
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function ContainerIs( src )
{
  if( _.argumentsArray.like( src ) || _.setLike( src ) )
  return true;
  if( src instanceof ContainerAdapter )
  return true;
  return false;
}

//

/**
 * @summary Check is argument allowed container either adapter of container.
 *
 * @function ContainerIsSet
 * @return {boolean} True if it is such thing.
 * @class wAbstractGraphSystem
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function ContainerIsSet( src )
{
  if( _.setLike( src ) )
  return true;
  if( src instanceof ContainerAdapterSet )
  return true;
  return false;
}

//

/**
 * @summary Check is argument allowed container either adapter of container.
 *
 * @function ContainerIsArray
 * @return {boolean} True if it is such thing.
 * @class wAbstractGraphSystem
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function ContainerIsArray( src )
{
  if( _.argumentsArray.like( src ) )
  return true;
  if( src instanceof ContainerAdapterArray )
  return true;
  return false;
}

//

/**
 * @summary Check is argument container adapter.
 *
 * @function ContainerIs
 * @return {boolean} True if it is such thing.
 * @class wAbstractGraphSystem
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function ContainerAdapterIs( src )
{
  if( src instanceof ContainerAdapter )
  return true;
  return false;
}

//

/**
 * @summary Return container of the adapter.
 *
 * @function OriginalOfAdapter
 * @return {container} Container of the adaptor.
 * @class wAbstractGraphSystem
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function OriginalOfAdapter( src )
{
  return ContainerAdapter.ToOriginal( src );
}

//

/**
 * @summary Make a new empty container for nodes.
 *
 * @function ContainerMake
 * @return {Container} Return new empty container for node. Empty Array by default.
 * @class wAbstractGraphSystem
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function ContainerMake()
{
  _.assert( arguments.length === 0, 'Expects no arguments' );
  return new Set;
  // return new Array;
}

//

/**
 * @summary Make a new empty container for nodes and adapter for the container.
 *
 * @function ContainerAdapterMake
 * @return {ContainerAdapter} Return new empty container for node. Empty Array by default.
 * @class wAbstractGraphSystem
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function ContainerAdapterMake()
{
  _.assert( arguments.length === 0, 'Expects no arguments' );
  return this.ContainerAdapterFrom( this.ContainerMake() );
}

//

/**
 * @summary Make adapter of a container for similar fast access to elements.
 *
 * @function ContainerAdapterFrom
 * @return {ContainerAdapter} Return ContainerAdapter not making a new one if passed in is such.
 * @class wAbstractGraphSystem
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function ContainerAdapterFrom( container )
{
  _.assert( arguments.length === 1 );
  return _.containerAdapter.from( container );
}

// --
// relations
// --

let FieldsForGroup =
{
  onNodeName : null,
  onNodeJunction : null,
  onNodeIs : null,
  onNodeOutNodes : null,
  onNodeInNodes : null,
  onNodeFrom : null,
}

let Composes =
{
}

let Aggregates =
{
  onNodeName : null,
  onNodeJunction : null,
  onNodeIs : null,
  onNodeOutNodes : null,
  onNodeInNodes : null,
  onNodeFrom : null,
}

let Associates =
{
  groups : _.define.instanceOf( Array ),
  collections : _.define.instanceOf( Array ),
}

let Restricts =
{
  nodeCounter : 0, /* xxx : deprecate? */
  // nodeToIdHash : _.define.instanceOf( HashMap ),
  // idToNodeHash : _.define.instanceOf( HashMap ),
  nodeDescriptorsHash : _.define.instanceOf( HashMap ),
}

let Statics =
{

  [ _.graph.AbstractNodesGroup.shortName2 ] : _.graph.AbstractNodesGroup,
  [ _.graph.AbstractNodesCollection.shortName2 ] : _.graph.AbstractNodesCollection,
  FieldsForGroup,

  // container adapter

  ContainerIs,
  ContainerAdapterIs,
  OriginalOfAdapter,
  ContainerMake,
  ContainerAdapterMake,
  ContainerAdapterFrom,

  ContainerAdapter,
  ContainerAdapterSet,
  ContainerAdapterArray,

}

let Forbids =
{
  onOutNodesIdsFor : 'onOutNodesIdsFor',
  onInNodesIdsFor : 'onInNodesIdsFor',
  nodeToIdHash : 'nodeToIdHash',
  idToNodeHash : 'idToNodeHash',
}

// --
// declare
// --

let Extension =
{

  init,
  finit,

  nodesGroup,
  nodesGroupDifferent,
  nodesCollection,

  // id

  // idIs,
  // idsAre : Vectorize( idIs ),
  // idsAreAll : VectorizeAll( idIs ),
  // idsAreAny : VectorizeAny( idIs ),
  // idsAreNone : VectorizeNone( idIs ),

  // node

  hasNode,
  hasNodes : Vectorize( hasNode ),
  hasAllNodes : VectorizeAll( hasNode ),
  hasAnyNodes : VectorizeAny( hasNode ),
  hasNoneNodes : VectorizeNone( hasNode ),

  // nodeToIdTry,
  // nodesToIdsTry : Vectorize( nodeToIdTry ),
  // nodeToId,
  // nodesToIds : Vectorize( nodeToId ),
  // idToNodeTry,
  // idsToNodesTry : Vectorize( idToNodeTry ),
  // idToNode,
  // idsToNodes : Vectorize( idToNode ),

  nodeDescriptorWithNode,
  nodeDescriptorWith,
  nodeDescriptorObtain,
  nodeDescriptorDelete,
  nodeDescriptorInc,
  nodeDescriptorDec,

  // container adapter

  ContainerIs,
  ContainerIsSet,
  ContainerIsArray,
  ContainerAdapterIs,
  OriginalOfAdapter,
  ContainerMake,
  ContainerAdapterMake,
  ContainerAdapterFrom,

  // relations

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extension,
});

_.Copyable.mixin( Self );

_.staticDeclare /* xxx : remove */
({
  prototype : _.graph.AbstractNodesGroup.prototype,
  name : 'System',
  value : Self,
});

_.staticDeclare /* xxx : remove */
({
  prototype : _.graph.AbstractNodesCollection.prototype,
  name : 'System',
  value : Self,
});

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
_.graph[ Self.shortName ] = Self;

})();
