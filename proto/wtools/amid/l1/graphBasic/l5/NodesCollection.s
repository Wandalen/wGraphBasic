( function _NodesCollection_s_( ) {

'use strict';

/**
 * @classdesc Class to operate graph as collection of nodes.
 * @class wAbstractNodesCollection
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

const _ = _global_.wTools;
let Group = _.graph.AbstractNodesGroup;
const Parent = null;
let Vectorize = _.routineDefaults( null, _.vectorize, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let VectorizeAll = _.routineDefaults( null, _.vectorizeAll, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let VectorizeAny = _.routineDefaults( null, _.vectorizeAny, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let VectorizeNone = _.routineDefaults( null, _.vectorizeNone, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
const Self = wAbstractNodesCollection;
function wAbstractNodesCollection( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'AbstractNodesCollection';
Self.shortName2 = 'Collection';

// --
// functor
// --

function _AssertMethods()
{
  if( !Config.debug )
  return true;

  let miss = [];
  for( let m in Group.prototype )
  {
    let method = Group.prototype[ m ];

    // if( m === 'nodesToNames' )
    // debugger;

    if( !_.routineIs( method ) )
    continue;
    if( method.properties === undefined )
    continue;
    if( !method.properties.forCollection )
    continue;
    if( _.routineIs( Self.prototype[ m ] ) )
    continue;
    miss.push( m );
  }

  if( miss.length )
  throw _.err
  (
      `Class ${Self.name} expects borrowed methods from class ${Group.name}. Please add to class declaration:`
    + '\n  ' + miss.map( ( m ) => `${m} : _MethodFromGroup( '${m}' )` ).join( ',\n  ' ) + ','
  );

  return true;
}

//

function _MethodFromGroup( o )
{
  let collectionMethod;
  if( !_.mapIs( arguments[ 0 ] ) )
  o = { methodName : arguments[ 0 ] }
  let methodName = o.methodName;
  let originalMethod = Group.prototype[ methodName ];

  _.assert( _.routineIs( originalMethod ), `Class ${Group.name} does not have method ${methodName}` );
  _.assert( _.aux.is( originalMethod.properties ) );
  _.assert( !!originalMethod.properties.forCollection, `Method ${o.methodName} is not for collection` );

  if( originalMethod.defaults )
  {
    let wrap =
    {
      [ methodName ] : function()
      {
        let collection = this;
        let sys = collection.sys;
        let group = collection.group;
        o = _.routine.options_( collectionMethod, arguments );
        o.nodes = collection.nodes;
        return originalMethod.call( group, o );
      }
    }
    collectionMethod = wrap[ methodName ];
    _.routineExtend( collectionMethod, originalMethod );
    _.assert( collectionMethod.defaults.nodes !== undefined );
    collectionMethod.defaults = _.props.extend( null, collectionMethod.defaults );
    delete collectionMethod.defaults.nodes;
    _.assert( collectionMethod.defaults.nodes === undefined );
    _.assert( originalMethod.defaults.nodes !== undefined );
  }
  else if( originalMethod.input === '(*Node)' )
  {
    let wrap =
    {
      [ methodName ] : function()
      {
        let collection = this;
        let sys = collection.sys;
        let group = collection.group;
        _.assert( arguments.length === 0, 'Expects no arguments' );
        return originalMethod.call( group, collection.nodes );
      }
    }
    collectionMethod = wrap[ methodName ];
    _.assert( originalMethod.input === '(*Node)' );
    _.routineExtend( collectionMethod, originalMethod );
  }
  else if( originalMethod.input === '(*Junction)' )
  {
    let wrap =
    {
      [ methodName ] : function()
      {
        let collection = this;
        let sys = collection.sys;
        let group = collection.group;
        _.assert( arguments.length === 0, 'Expects no arguments' );
        _.assert( 0, 'not tested' );
        return originalMethod.call( group, group.nodesToJunctions( collection.nodes ).once() );
      }
    }
    collectionMethod = wrap[ methodName ];
    _.assert( originalMethod.input === '(*Junction)' );
    _.routineExtend( collectionMethod, originalMethod );
  }
  else _.assert( 0, `Not clear how what is input of ${methodName}` );

  return collectionMethod;
}

_MethodFromGroup.defaults =
{
  methodName : null,
}

// --
// routine
// --

function init( o )
{
  let collection = this;

  _.assert( _.object.isBasic( o ) );
  _.assert( o.sys instanceof _.graph.AbstractGraphSystem );

  let sys = o.sys;
  let group = o.group;

  collection[ nodesSymbol ] = sys.ContainerAdapterFrom( new Set );

  _.workpiece.initFields( collection );
  Object.preventExtensions( collection );

  _.assert( sys.ContainerAdapterIs( collection.nodes ) && collection.nodes.length === 0 );

  if( o )
  collection.copy( o );

  _.assert( collection.sys instanceof _.graph.AbstractGraphSystem );
  _.assert( collection.group instanceof _.graph.AbstractNodesGroup );

  _.arrayAppendOnceStrictly( sys.collections, collection );
  _.arrayAppendOnceStrictly( group.collections, collection );

  // collection.form();

  return collection;
}

//

function finit()
{
  let collection = this;
  let sys = collection.sys;
  let group = collection.group;

  collection.nodesDelete();

  _.arrayRemoveOnceStrictly( sys.collections, collection );

  let removedFromGroup = _.arrayRemovedOnce( group.collections, collection ) > -1;
  if( removedFromGroup && !group.isUsed() )
  group.finit();

  // collection.unform();
  return _.Copyable.prototype.finit.call( collection );
}

//

function precopy( o )
{
  let collection = this;

  _.assert( _.object.isBasic( o ) );
  _.assert( arguments.length === 1 );

  if( o.sys !== undefined )
  collection.sys = o.sys;
  if( o.group !== undefined )
  collection.group = o.group;

}

//

function copy( o )
{
  let collection = this;

  _.assert( _.object.isBasic( o ) );
  _.assert( arguments.length === 1 );

  collection.precopy( o );

  return _.Copyable.prototype.copy.call( collection, o );
}

// --
// etc
// --

// //
//
// function exportString( o )
// {
//   let collection = this;
//   let sys = collection.sys;
//   let group = collection.group;
//
//   o = _.routine.options_( exportString, arguments );
//   o.nodes = collection.nodes;
//
//   return group.exportString( o );
// }
//
// var defaults = exportString.defaults =
// {
//   ... Group.prototype.exportString.defaults,
// }
//
// delete defaults.nodes;

// --
// nodes
// --

function nodesSet( nodes )
{
  let collection = this;
  let sys = collection.sys;
  let group = collection.group;

  _.assert( arguments.length === 1 );
  _.assert( nodes === null || sys.ContainerIs( nodes ) );

  if( nodes )
  if( collection.nodes.original === sys.OriginalOfAdapter( nodes ) )
  return collection.nodes;

  collection.nodesDelete( collection.nodes.make() );
  if( nodes )
  collection.nodesAdd( nodes );

  return collection.nodes;
}

//

/**
 * @summary Returns true if group has provided node. Takes node handle as argument.
 * @param {Object} node Node descriptor.
 * @function hasNode
 * @class wAbstractNodesCollection
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function hasNode( node )
{
  let collection = this;
  let group = collection.group;
  let sys = collection.sys;
  _.assert( !!group.nodeIs( node ) );
  return collection.nodes.has( node );
}

//

/**
 * @summary Adds provided node `node` to current collection. Make no conversion of the node
 * @param {Object} node Node.
 * @function _nodeAdd
 * @returns {Number} Returns id of added node.
 * @class wAbstractNodesCollection
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function _nodeAdd( node )
{
  let collection = this;
  let sys = collection.sys;
  let group = collection.group;

  _.assert( !collection.nodes.has( node ), () => `The collection already has ${group.nodeToQualifiedNameTry( node )}` );
  collection.nodes.appendOnceStrictly( node );

  sys.nodeDescriptorInc( node );

  // let wasDefined = true;
  // let id = sys.nodeToIdTry( node );
  // if( id === undefined )
  // {
  //   id = ++sys.nodeCounter;
  //   wasDefined = false;
  // }
  //
  // sys.nodeToIdHash.set( node, id );
  // sys.idToNodeHash.set( id, node );

  // if( collection._inNodesCacheHash )
  // debugger;
  // if( collection._inNodesCacheHash )
  // collection.cacheInNodesFromOutNodesUpdateNode( node );

  // if( wasDefined )
  // {
  //   let descriptor = sys.nodeDescriptorObtain( id );
  //   descriptor.count += 1;
  // }

  // return id;
  return node;
}

//

/**
 * @summary Adds provided node `node` to current collection. Make conversion of the node if required.
 * @param {Object} node Node to add .
 * @function nodeAdd
 * @returns {Number} Returns id of added node.
 * @class wAbstractNodesCollection
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

 /**
 * @summary Adds several nodes to the system. Make conversion of nodes if required.
 * @param {Array} node Array of nodes.
 * @function nodesAdd
 * @returns {Node} Returns added node.
 * @class wAbstractNodesCollection
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function nodeAdd( node )
{
  let collection = this;
  let sys = collection.sys;
  let group = collection.group;

  _.assert( arguments.length === 1 );

  node = group.nodeFrom( node );

  return collection._nodeAdd( node );
}

//

/**
 * @summary Adds a node to the collection. Ignores dublicates. Does not make conversion of node.
 * @param {Object} node Node.
 * @function _nodeAddOnce
 * @returns {Number} Returns id of added node.
 * @class wAbstractNodesCollection
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

/**
 * @summary Adds a node to the collection. Ignores dublicates. Makes conversion of the node if required.
 * @param {Object} node Node.
 * @function nodeAddOnce
 * @returns {Number} Returns id of added node.
 * @class wAbstractNodesCollection
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

 /**
 * @summary Adds sevelal nodes to the collection. Ignores dublicates. Makes conversion of nodes if required.
 * @param {Array of Node} node Array of nodes.
 * @function nodesAddOnce
 * @returns {Array} Returns array of ids of added nodes.
 * @class wAbstractNodesCollection
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function _nodeAddOnce( node )
{
  let collection = this;
  let sys = collection.sys;
  let group = collection.group;

  if( collection.nodes.has( node ) )
  {
    return node;
    // return sys.nodeToIdHash.get( node );
  }

  return collection._nodeAdd( node );
}

//

function nodeAddOnce( node )
{
  let collection = this;
  let sys = collection.sys;
  let group = collection.group;

  node = group.nodeFrom( node );

  return collection._nodeAddOnce( node );
}

//

/**
 * @summary Removes node `node` from current collection.
 * @param {Object} node Node descriptor.
 * @function nodeDelete
 * @returns {Number} Returns id of removed node.
 * @throws {Error} If system doesn't have node with such `node`.
 * @class wAbstractNodesCollection
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

function nodeDelete( node )
{
  let collection = this;
  let sys = collection.sys;
  let group = collection.group;
  // let id = sys.nodeToId( node );
  // let descriptor = sys.nodeDescriptorWith( node );

  _.assert( arguments.length === 1 );
  _.assert( !!group.nodeIs( node ), 'Expects node' );
  // _.assert( descriptor === null || descriptor.count > 0, 'The system does not have information about number of the node' );
  _.assert( collection.nodes.has( node ), () => `The collection does not have ${group.nodeToQualifiedNameTry( node )}` );
  collection.nodes.removedOnceStrictly( node );

  sys.nodeDescriptorDec( node );

  // if( descriptor && descriptor.count > 1 )
  // {
  //   debugger;
  //   descriptor.count -= 1;
  // }
  // else
  // {
  //   // sys.nodeToIdHash.delete( node );
  //   // sys.idToNodeHash.delete( id );
  //   // sys.nodeDescriptorDelete( id );
  //   sys.nodeDescriptorDelete( node );
  // }

  return node;
}

//

/**
 * @summary Removes several nodes from system.
 * @param {Array} node Array of nodes.
 * @function nodesDelete
 * @returns {Array} Returns array with ids of removed nodes.
 * @throws {Error} If system doesn't have node with such `node`.
 * @class wAbstractNodesCollection
 * @namespace wTools
 * @module Tools/mid/AbstractGraphs.wTools.graph
 */

let _nodesDelete = Vectorize( nodeDelete );
function nodesDelete()
{
  let collection = this;
  let sys = collection.sys;
  let group = collection.group;

  if( arguments.length === 0 )
  return collection.nodesDelete( collection.nodes.make() );
  // return collection.nodesDelete( collection.nodes.slice() );
  _.each( arguments, ( node ) => _nodesDelete.call( collection, node ) );
  // return _nodesDelete.apply( this, arguments );
}

// --
// relations
// --

let nodesSymbol = Symbol.for( 'nodes' );

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{
  sys : null,
  nodes : _.define.own([]),
  group : null,
}

let Restricts =
{
  // _inNodesCacheHash : null, /* xxx : move here maybe */
}

let Statics =
{
}

let Forbids =
{
  onOutNodesIdsFor : 'onOutNodesIdsFor',
  onInNodesIdsFor : 'onInNodesIdsFor',
}

let Accessors =
{
  nodes : { set : nodesSet },
}

// --
// declare
// --

let Extension =
{

  // inter

  init,
  finit,

  precopy,
  copy,

  // from group

  exportString : _MethodFromGroup( 'exportString' ),
  leastIndegreeAmong : _MethodFromGroup( 'leastIndegreeAmong' ),
  mostIndegreeAmong : _MethodFromGroup( 'mostIndegreeAmong' ),
  leastOutdegreeAmong : _MethodFromGroup( 'leastOutdegreeAmong' ),
  mostOutdegreeAmong : _MethodFromGroup( 'mostOutdegreeAmong' ),
  leastIndegreeOnlyAmong : _MethodFromGroup( 'leastIndegreeOnlyAmong' ),
  mostIndegreeOnlyAmong : _MethodFromGroup( 'mostIndegreeOnlyAmong' ),
  leastOutdegreeOnlyAmong : _MethodFromGroup( 'leastOutdegreeOnlyAmong' ),
  mostOutdegreeOnlyAmong : _MethodFromGroup( 'mostOutdegreeOnlyAmong' ),
  sourcesOnlyAmong : _MethodFromGroup( 'sourcesOnlyAmong' ),
  sinksOnlyAmong : _MethodFromGroup( 'sinksOnlyAmong' ),
  dagTopSortDfs : _MethodFromGroup( 'dagTopSortDfs' ),
  dagTopSort : _MethodFromGroup( 'dagTopSort' ),
  topSortLeastDegreeBfs : _MethodFromGroup( 'topSortLeastDegreeBfs' ),
  topSortCycledSourceBasedFastBfs : _MethodFromGroup( 'topSortCycledSourceBasedFastBfs' ),
  topSortCycledSourceBasedPrecise : _MethodFromGroup( 'topSortCycledSourceBasedPrecise' ),
  topSort : _MethodFromGroup( 'topSort' ),
  nodesConnectedLayersDfs : _MethodFromGroup( 'nodesConnectedLayersDfs' ),
  nodesConnectedLayers : _MethodFromGroup( 'nodesConnectedLayers' ),
  nodesStronglyConnectedLayersDfs : _MethodFromGroup( 'nodesStronglyConnectedLayersDfs' ),
  nodesStronglyConnectedLayers : _MethodFromGroup( 'nodesStronglyConnectedLayers' ),
  nodesStronglyConnectedCollectionDfs : _MethodFromGroup( 'nodesStronglyConnectedCollectionDfs' ),
  nodesStronglyConnectedCollection : _MethodFromGroup( 'nodesStronglyConnectedCollection' ),

  nodesAre : _MethodFromGroup( 'nodesAre' ),
  nodesAreAll : _MethodFromGroup( 'nodesAreAll' ),
  nodesAreAny : _MethodFromGroup( 'nodesAreAny' ),
  nodesAreNone : _MethodFromGroup( 'nodesAreNone' ),
  nodesIndegree : _MethodFromGroup( 'nodesIndegree' ),
  nodesOutdegree : _MethodFromGroup( 'nodesOutdegree' ),
  nodesDegree : _MethodFromGroup( 'nodesDegree' ),
  nodesOutNodesFor : _MethodFromGroup( 'nodesOutNodesFor' ),
  nodesInNodesFor : _MethodFromGroup( 'nodesInNodesFor' ),
  nodesToNames : _MethodFromGroup( 'nodesToNames' ),
  nodesToNamesTry : _MethodFromGroup( 'nodesToNamesTry' ),
  nodesJunctions : _MethodFromGroup( 'nodesJunctions' ),

  // junctionsAre : _MethodFromGroup( 'junctionsAre' ),
  // junctionsAreAll : _MethodFromGroup( 'junctionsAreAll' ),
  // junctionsAreAny : _MethodFromGroup( 'junctionsAreAny' ),
  // junctionsAreNone : _MethodFromGroup( 'junctionsAreNone' ),
  // junctionsNodes : _MethodFromGroup( 'junctionsNodes' ),

  junctionsAre : _MethodFromGroup( 'junctionsAre' ),
  junctionsAreAll : _MethodFromGroup( 'junctionsAreAll' ),
  junctionsAreAny : _MethodFromGroup( 'junctionsAreAny' ),
  junctionsAreNone : _MethodFromGroup( 'junctionsAreNone' ),
  junctionsToNames : _MethodFromGroup( 'junctionsToNames' ),
  junctionsNodes : _MethodFromGroup( 'junctionsNodes' ),

  // nodes

  nodesSet,

  hasNode,
  hasNodes : Vectorize( hasNode ),
  hasAllNodes : VectorizeAll( hasNode ),
  hasAnyNodes : VectorizeAny( hasNode ),
  hasNoneNodes : VectorizeNone( hasNode ),

  _nodeAdd,
  nodeAdd,
  nodesAdd : Vectorize( nodeAdd ),
  _nodeAddOnce,
  nodeAddOnce,
  nodesAddOnce : Vectorize( nodeAddOnce ),
  nodeDelete,
  nodesDelete,

  // ids

  // nodeToIdTry,
  // nodesToIdsTry : Vectorize( nodeToIdTry ),
  // nodeToId,
  // nodesToIds : Vectorize( nodeToId ),
  // idToNodeTry,
  // idsToNodesTry : Vectorize( idToNodeTry ),
  // idToNode,
  // idsToNodes : Vectorize( idToNode ),
  // idToName,
  // idsToNames : Vectorize( idToName ),

  // relations

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,
  Accessors,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extension,
});

_.Copyable.mixin( Self );

_AssertMethods();

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
_.graph[ Self.shortName ] = Self;

})();
