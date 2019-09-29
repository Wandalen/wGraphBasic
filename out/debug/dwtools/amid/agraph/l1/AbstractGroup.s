( function _NodesGroup_s_( ) {

'use strict';

/**
 * @classdesc Class to operate graph as group of nodes.
 * @class wAbstractNodesGroup
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph
 */

let _ = _global_.wTools;
let Parent = null;
let ContainerAdapter = _.containerAdapter.Abstract;
let SetContainerAdapter = _.containerAdapter.Set;
let ArrayContainerAdapter = _.containerAdapter.Array;
let vectorize = _.routineDefaults( null, _.vectorize, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let Self = function wAbstractNodesGroup( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'AbstractNodesGroup';

// --
// routine
// --

function init( o )
{
  let group = this;

  group[ nodesSymbol ] = group.ContainerAdapterFrom( new Set );

  _.workpiece.initFields( group );
  Object.preventExtensions( group );

  // debugger;
  _.assert( group.ContainerAdapterIs( group.nodes ) && group.nodes.length === 0 );
  // _.assert( _.arrayIs( group.nodes ) && group.nodes.length === 0 );

  if( o )
  group.copy( o );

  group.form();

  return group;
}

//

function finit()
{
  let group = this;
  group.unform();
  _.Copyable.prototype.finit.call( group );
}

//

function form()
{
  let group = this;
  _.assert( group.sys instanceof group.System );
  _.arrayAppendOnceStrictly( group.sys.groups, group );
}

//

function unform()
{
  let group = this;
  group.nodesDelete();
  _.arrayRemoveOnceStrictly( group.sys.groups, group );
}

//

function clone()
{
  let group = this;
  let group2 = _.Copyable.prototype.clone.apply( group, arguments );
  return group2;
}

// --
// reverse
// --

function directSet( val )
{
  let group = this;

  _.assert( arguments.length === 1 );
  _.assert( _.boolLike( val ) );

  val = !!val;

  if( group[ directSymbol ] === undefined )
  {
    group[ directSymbol ] = val;
    return val;
  }

  group.reverse( val );

  return val;
}

//

function reverse( val )
{
  let group = this;

  if( val === undefined )
  val = !group.direct;
  else
  val = !!val;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( group.direct === val )
  return group;

  if( !val && !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce();

  let onOutNodesGet = group.onOutNodesGet;
  let onInNodesGet = group.onInNodesGet;

  _.assert( _.routineIs( onOutNodesGet ), 'Direct neighbour nodes getter is not defined' );
  _.assert( _.routineIs( onInNodesGet ), 'Reverse neighbour nodes getter is not defined' );

  group.onOutNodesGet = onInNodesGet;
  group.onInNodesGet = onOutNodesGet;

  group[ directSymbol ] = val;
  return group;
}

//

function cacheInNodesFromOutNodesOnce( nodes )
{
  let group = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( group._inNodesCacheHash )
  return group._inNodesCacheHash;

  return group.cacheInNodesFromOutNodesUpdate( nodes );
}

//

function cacheInNodesFromOutNodesUpdate( nodes )
{
  let group = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes );

  if( !group.onInNodesGet )
  group.onInNodesGet = group.inNodesFromGroupCache;

  if( !group._inNodesCacheHash )
  group._inNodesCacheHash = new HashMap();
  nodes.each( ( node1 ) =>
  {
    group._inNodesCacheHash.set( node1, new Array );
  });

  // debugger;
  nodes.each( ( node1 ) =>
  {
    let directNeighbours = group.nodeOutNodesFor( node1 );
    directNeighbours = group.ContainerAdapterFrom( directNeighbours );
    directNeighbours.each( ( node2 ) =>
    {
      let reverseNeighbours = group._inNodesCacheHash.get( node2 );
      _.assert( !!reverseNeighbours, `Cant retrive in nodes of ${group.nodeToQualifiedName( node2 )} from cache` );
      reverseNeighbours.push( node1 );
    });
  });

  // debugger;
  return group._inNodesCacheHash;
}

//

function cachesInvalidate()
{
  let group = this;
  debugger;
  _.assert( 'not tested' );
  if( group._inNodesCacheHash )
  group._inNodesCacheHash.clear();
  group._inNodesCacheHash = null;
  return group;
}

// --
// exporter
// --

function optionsExport()
{
  let group = this;
  let result = Object.create( null );
  result.onNodeNameGet = group.onNodeNameGet;
  result.onNodeEvaluate = group.onNodeEvaluate;
  result.onNodeIs = group.onNodeIs;
  result.onOutNodesGet = group.onOutNodesGet;
  result.onInNodesGet = group.onInNodesGet;
  return result
}

//

function structureExport( o )
{
  let group = this;
  let sys = group.sys;

  o = _.routineOptions( structureExport, arguments );

  if( o.nodes === null )
  o.nodes = group.nodes;
  else
  o.nodes = group.nodesAsAdapter( o.nodes );

  let result = Object.create( null );
  result.nodes = group.nodesDataExport( o.nodes );

  return result;
}

structureExport.defaults =
{
  nodes : null,
}

//

/**
 * @summary Returns string with information about nodes relation.
 * @description
 * For example we have three nodes 'a','b','c' with ids: 1,2,3.
 * Edges between nodes: 'a','b' and 'b','c'.
 * Relation info will look like:
 *  1 : 2
 *  2 : 3
 *  3 :
 * @function infoExport
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function infoExport( o )
{
  let group = this;
  let sys = group.sys;

  o = _.routineOptions( infoExport, arguments );

  if( o.nodes === null )
  o.nodes = group.nodes;
  else
  o.nodes = group.nodesAsAdapter( o.nodes );

  let result = group.nodesInfoExport( o.nodes, o );

  return result;
}

infoExport.defaults =
{
  verbosity : 2,
  nodes : null,
}

//

/**
 * @summary Returns descriptor of node with id `nodeId`.
 * @param {Number} nodeId Id of target node.
 * @function nodeDescriptorWithId
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeDescriptorWithId( nodeId )
{
  let group = this;
  let sys = group.sys;
  return sys.nodeDescriptorWithId.apply( sys, arguments );
}

//

function nodeDescriptorWith( nodeId )
{
  let group = this;
  let sys = group.sys;
  return sys.nodeDescriptorWith.apply( sys, arguments );
}

//

/**
 * @summary Returns descriptor of node with id `nodeId`. Creates new descriptor if it doesn't exist.
 * @param {Number} nodeId Id of target node.
 * @function nodeDescriptorObtain
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeDescriptorObtain( nodeId )
{
  let group = this;
  let sys = group.sys;
  return sys.nodeDescriptorObtain.apply( sys, arguments );
}

//

function nodeDescriptorDelete( nodeId )
{
  let group = this;
  let sys = group.sys;
  return sys.nodeDescriptorDelete.apply( sys, arguments );
}

// --
// node
// --

/**
 * @summary Returns true if group has provided node. Takes node handle as argument.
 * @param {Object} node Node descriptor.
 * @function hasNode
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function hasNode( node )
{
  let group = this;
  _.assert( !!group.nodeIs( node ) ); debugger;
  return group.nodes.has( node );
  // return _.arrayHas( group.nodes, node, group.onNodeEvaluate || undefined );
}

//

/**
 * @summary Returns true if provided entity `node` is a node.
 * @param {Object} node Node descriptor.
 * @function nodeIs
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeIs( node )
{
  let group = this;
  return group.onNodeIs( node );
}

// --
// node
// --

function nodeIndegree( node )
{
  let group = this;
  let nodes = group.nodeInNodesFor( node );
  return nodes.length;
}

//

function nodeOutdegree( node )
{
  let group = this;
  let nodes = group.nodeOutNodesFor( node );
  return nodes.length;
}

//

function nodeDegree( node )
{
  let group = this;
  let nodes1 = group.nodeInNodesFor( node );
  let nodes2 = group.nodeOutNodesFor( node );
  return nodes1.length + nodes2.length;
}

//

function nodeOutNodesFor( node )
{
  let group = this;
  _.assert( !!group.nodeIs( node ), 'Not a node' );
  _.assert( arguments.length === 1 );
  let result = group.ContainerAdapterFrom( group.onOutNodesGet( node ) );
  _.assert( group.ContainerIs( result ), () => `Cant retrive out nodes of ${group.nodeToQualifiedNameTry( node )}` );
  return result;
}

//

function nodeInNodesFor( node )
{
  let group = this;
  _.assert( !!group.nodeIs( node ), 'Not a node' );
  _.assert( arguments.length === 1 );
  let result = group.ContainerAdapterFrom( group.onInNodesGet( node ) );
  _.assert( group.ContainerIs( result ), () => `Cant retrive out nodes of ${group.nodeToQualifiedNameTry( node )}` );
  return result;
}

//

function nodeOutNodesIdsFor( node )
{
  let group = this;
  _.assert( !!group.nodeIs( node ) );
  _.assert( arguments.length === 1 );

  let result = group.nodesToIds( group.onOutNodesGet( node ) );

  _.assert( group.ContainerIs( result ) );
  return result;
}

//

function nodeInNodesIdsFor( node )
{
  let group = this;
  _.assert( !!group.nodeIs( node ) );
  _.assert( arguments.length === 1 );

  let result = group.nodesToIds( group.onInNodesGet( node ) );

  _.assert( group.ContainerIs( result ) );
  return result;
}

//

function nodeRefNumber( nodeId )
{
  let group = this;
  let sys = group.sys;

  _.assert( arguments.length === 1 );
  _.assert( !!nodeId, 'Expects node or node id' );
  _.assert( 'not tested' );

  if( !sys.idIs( nodeId ) )
  {
    nodeId = group.nodeToId( nodeId );
  }

  let descriptor = group.nodeDescriptorWithId( nodeId );

  if( !descriptor )
  if( sys.idToNodeHash.has( nodeId ) )
  return 1;
  else
  return 0;

  _.assert( descriptor.count >= 0 );

  return descriptor.count;
}

//

function nodesSet( nodes )
{
  let group = this;
  let sys = group.sys;

  _.assert( arguments.length === 1 );
  _.assert( nodes === null || group.ContainerIs( nodes ) );

  if( nodes )
  if( group.nodes.original === group.OriginalOfAdapter( nodes ) )
  return group.nodes;

  group.nodesDelete( group.nodes.make() );
  if( nodes )
  group.nodesAdd( nodes );

  return group.nodes;
}

//

/**
 * @summary Adds provided node `node` to current group.
 * @param {Object} node Node descriptor.
 * @function nodeAdd
 * @returns {Number} Returns id of added node.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

 /**
 * @summary Adds several nodes to the system.
 * @param {Array} node Array with node descriptors.
 * @function nodesAdd
 * @returns {Array} Returns array with ids of added nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeAdd( node )
{
  let group = this;
  let sys = group.sys;

  _.assert( !!group.nodeIs( node ), 'Expects node' );
  // _.assert( !_.arrayHas( group.nodes, node, group.onNodeEvaluate || undefined ), 'The group does not have a node with such node' );
  _.assert( !group.nodes.has( node ), () => `The group already has ${group.nodeToQualifiedNameTry( node )}` );
  // _.arrayAppendOnceStrictly( group.nodes, node, group.onNodeEvaluate || undefined );
  group.nodes.appendOnceStrictly( node );

  let wasDefined = true;
  let id = sys.nodeToIdTry( node );
  if( id === undefined )
  {
    id = ++sys.nodeCounter;
    wasDefined = false;
  }

  sys.nodeToIdHash.set( node, id );
  sys.idToNodeHash.set( id, node );

  if( wasDefined )
  {
    let descriptor = sys.nodeDescriptorObtain( id );
    descriptor.count += 1;
  }

  return id;
}

//

/**
 * @summary Removes node `node` from current group.
 * @param {Object} node Node descriptor.
 * @function nodeDelete
 * @returns {Number} Returns id of removed node.
 * @throws {Error} If system doesn't have node with such `node`.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeDelete( node )
{
  let group = this;
  let sys = group.sys;
  let id = sys.nodeToId( node );
  let descriptor = group.nodeDescriptorWith( node );

  _.assert( !!group.nodeIs( node ), 'Expects node' );
  _.assert( descriptor === null || descriptor.count > 0, 'The system does not have information about number of the node' );
  // _.assert( _.arrayHas( group.nodes, node, group.onNodeEvaluate || undefined ), 'The group does not have a node with such node' );
  _.assert( group.nodes.has( node ), () => `The group does not have ${group.nodeToQualifiedNameTry( node )}` );
  group.nodes.removedOnceStrictly( node );
  // _.arrayRemoveOnceStrictly( group.nodes, node, group.onNodeEvaluate || undefined );

  if( descriptor && descriptor.count > 1 )
  {
    descriptor.count -= 1;
  }
  else
  {
    sys.nodeToIdHash.delete( node );
    sys.idToNodeHash.delete( id );
    sys.nodeDescriptorDelete( id );
  }

  return id;
}

//

/**
 * @summary Removes several nodes from system.
 * @param {Array} node Array with node descriptors.
 * @function nodesDelete
 * @returns {Array} Returns array with ids of removed nodes.
 * @throws {Error} If system doesn't have node with such `node`.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

let _nodesDelete = vectorize( nodeDelete );
function nodesDelete()
{
  let group = this;
  if( arguments.length === 0 )
  return group.nodesDelete( group.nodes.make() );
  // return group.nodesDelete( group.nodes.slice() );
  return _nodesDelete.apply( this, arguments );
}

//

function nodeDataExport( node )
{
  let group = this;

  _.assert( group.nodeIs( node ) );

  let result = Object.create( null );
  result.id = group.nodeToId( node );
  result.outNodeIds = group.nodesToIdsTry( group.nodeOutNodesFor( node ) );

  return result;
}

//

function nodeInfoExport( node, opts )
{
  let group = this;

  // let data = group.nodeDataExport( node );
  // let result = group.nodeToName( node ) + ' : ';
  // let outNames = group.nodesToNamesTry( group.idsToNodesTry( data.outNodeIds ) );
  // result += outNames.join( ' ' );

  if( group.onNodeInfoExport )
  debugger;
  if( group.onNodeInfoExport )
  return group.onNodeInfoExport( node, o );

  let name = group.nodeToName( node );
  // debugger;
  let outNames = group.nodesToNames( group.nodeOutNodesFor( node ) );

  let result = name + ' : ' + outNames.join( ' ' );
  return result;
}

//

function nodesInfoExport( nodes, opts )
{
  let group = this;
  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 )

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes );

  let result = nodes.map( ( node ) => group.nodeInfoExport( node, opts ) );

  result = result.join( '\n' );
  return result;
}

//

function nodesExportInfoTree( nodes, opts )
{
  let group = this;
  let result = '';
  let prevIt;
  let lastNodes;
  let tab;

  opts = _.routineOptions( nodesExportInfoTree, opts );

  _.assert( opts.dtab1.length === opts.dtab2.length );
  _.assert( _.arrayIs( nodes ) );

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( group.nodesAreAll( nodes ) );

  nodes.each( ( node, i ) =>
  {
    lastNodes = Object.create( null );
    tab = '';

    if( opts.rootsDelimiting && i > 0 )
    result += opts.linePrefix + opts.dtab1 + opts.linePostfix;

    prevIt = { level : 0 };
    group.lookDfs
    ({
      roots : node,
      onBegin : handleBegin,
      onUp : handleUp1,
      onDown : handleDown1,
      fast : 0,
      revisiting : 1,
    });
    lastNodes[ '0' ] = nodes.length -1 === i;

    prevIt = { level : 0, path : [] };
    group.lookDfs
    ({
      roots : node,
      onBegin : handleBegin,
      onUp : handleUp2,
      onDown : handleDown2,
      fast : 0,
      revisiting : 1,
    });

  });

  return result;

  /* */

  function handleBegin( it )
  {
    it.path = [];
  }

  /* */

  function handleUp1( node, it )
  {
    it.path = it.prev.path.slice();
    it.path.push( it.index );
  }

  /* */

  function handleDown1( node, it )
  {
    let dLevel = it.level - prevIt.level;
    if( dLevel < 0 )
    lastNodes[ prevIt.path.join( '/' ) ] = true;
    prevIt = it;
  }

  /* */

  function handleUp2( node, it )
  {
    it.path = it.prev.path.slice();
    it.path.push( it.index );

    let isLast = !!lastNodes[ prevIt.path.join( '/' ) ];
    let dLevel = it.level - prevIt.level;
    let name = group.nodeToName( node );

    if( dLevel < 0 )
    tab = tab.substring( 0, tab.length + dLevel*opts.dtab1.length );

    if( dLevel > 0 )
    tab += isLast ? opts.dtab2 : opts.dtab1;

    let tab2 = tab;

    tab2 = opts.tabPrefix + tab2 + opts.tabPostfix;

    result += opts.linePrefix + tab2 + name + opts.linePostfix;

    prevIt = it;
  }

  /* */

  function handleDown2( node, it )
  {
    // _.assert( it.index === it.path[ it.path.length-1 ] );
    // it.path.pop();
  }

}

nodesExportInfoTree.defaults =
{
  linePrefix : ' ',
  linePostfix : '\n',
  tabPrefix : '',
  tabPostfix : '+-- ',
  dtab1 : '| ',
  dtab2 : '  ',
  rootsDelimiting : 1,
}

//

/**
 * @summary Returns qualified name of node. Takes single argument - a node.
 * @param {Object} node Node descriptor.
 * @function nodeToQualifiedName
 * @returns {String} Returns name of node.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeToQualifiedName( node )
{
  let group = this;
  let result;

  _.assert( !!group.nodeIs( node ), 'Expects node' );
  _.assert( arguments.length === 1 );

  if( group.onNodeQualifiedNameGet === null )
  result = 'node::' + group.nodeToName( node );
  else
  result = group.onNodeQualifiedNameGet( node );

  _.assert( _.primitiveIs( result ) && result !== undefined, 'Cant get qualified name for the node' );

  return String( result );
}

//

/**
 * @summary Try to return qualified name of node. Takes single argument - a node.
 * @param {Object} node Node descriptor.
 * @function nodeToQualifiedNameTry
 * @returns {String} Returns name of node.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeToQualifiedNameTry( node )
{
  let group = this;
  try
  {
    let result = group.nodeToQualifiedName( node );
    return result;
  }
  catch( err )
  {
    return '';
  }
}

//

/**
 * @summary Returns name of node. Takes single argument - a node.
 * @param {Object} node Node descriptor.
 * @function nodeToName
 * @returns {String} Returns name of node.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeToName( node )
{
  let group = this;
  let result;

  _.assert( !!group.nodeIs( node ), 'Expects node' );
  _.assert( arguments.length === 1 );

  if( group.onNodeNameGet === null )
  result = group.nodeNameFromGetterId( node );
  else
  result = group.onNodeNameGet( node );

  _.assert( _.primitiveIs( result ) && result !== undefined, 'Cant get name for the node' );

  return String( result );
}

//

function nodeToNameTry( node )
{
  let group = this;
  let sys = group.sys;
  if( !group.nodeIs( node ) )
  return undefined;
  _.assert( arguments.length === 1 );
  return group.nodeToName( node );
}

//

/**
 * @summary Returns id of node. Takes single argument - a node.
 * @description Returns undefined if can't get id of provided node.
 * @param {Object} node Node descriptor.
 * @function nodeToIdTry
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeToIdTry( node )
{
  let group = this;
  let sys = group.sys;
  return sys.nodeToIdTry( node );
}

//

/**
 * @summary Returns id of node. Takes single argument - a node.
 * @param {Object} node Node descriptor.
 * @function nodeToId
 * @throws {Error} If can't get id of provided node.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodeToId( node )
{
  let group = this;
  let sys = group.sys;

  if( group.onNodeIdGet )
  return group.onNodeIdGet( node );

  return sys.nodeToId( node );
}

//

function idToNodeTry( nodeId )
{
  let group = this;
  let sys = group.sys;
  return sys.idToNodeTry( nodeId );
}

//

function idToNode( nodeId )
{
  let group = this;
  let sys = group.sys;
  return sys.idToNode( nodeId );
}

//

function idToName( nodeId )
{
  let group = this;
  let node = group.idToNode( nodeId );
  return group.nodeToName( node );
}

// --
// filter
// --

function leastIndegreeAmong( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce( nodes );

  let result = Infinity;

  nodes.each( ( node ) =>
  {
    let d = group.nodeIndegree( node );
    if( d < result )
    result = d;
  });

  if( result === Infinity )
  result = 0;

  return result;
}

//

function mostIndegreeAmong( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce( nodes );

  let result = 0;

  nodes.each( ( node ) =>
  {
    let d = group.nodeIndegree( node );
    if( d > result )
    result = d;
  });

  return result;
}

//

function leastOutdegreeAmong( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  // if( !group.onInNodesGet )
  // group.cacheInNodesFromOutNodesOnce( nodes );

  let result = Infinity;

  nodes.each( ( node ) =>
  {
    let d = group.nodeOutdegree( node );
    if( d < result )
    result = d;
  });

  if( result === Infinity )
  result = 0;

  return result;
}

//

function mostOutdegreeAmong( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  // if( !group.onInNodesGet )
  // group.cacheInNodesFromOutNodesOnce( nodes );

  let result = 0;

  nodes.each( ( node ) =>
  {
    let d = group.nodeOutdegree( node );
    if( d > result )
    result = d;
  });

  return result;
}

//

function leastIndegreeOnlyAmong( nodes )
{
  let group = this;
  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let degree = group.leastIndegreeAmong( nodes );
  let result = nodes.filter( ( node ) => group.nodeIndegree( node ) === degree ? node : undefined );
  return result;
}

//

function mostIndegreeOnlyAmong( nodes )
{
  let group = this;
  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let degree = group.mostIndegreeAmong( nodes );
  let result = nodes.filter( ( node ) => group.nodeIndegree( node ) === degree ? node : undefined );
  return result;
}


//

function leastOutdegreeOnlyAmong( nodes )
{
  let group = this;
  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let degree = group.leastOutdegreeAmong( nodes );
  let result = nodes.filter( ( node ) => group.nodeOutdegree( node ) === degree ? node : undefined );
  return result;
}

//

function mostOutdegreeOnlyAmong( nodes )
{
  let group = this;
  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let degree = group.mostOutdegreeAmong( nodes );
  let result = nodes.filter( ( node ) => group.nodeOutdegree( node ) === degree ? node : undefined );
  return result;
}

//

function sourcesOnlyAmong( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce( nodes );

  let result = nodes.filter( ( node ) => group.nodeInNodesFor( node ).length === 0 ? node : undefined );

  return result;
}

//

function sinksOnlyAmong( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  let result = nodes.filter( ( node ) => group.nodesOutNodesFor( node ).length === 0 ? node : undefined );

  return result;
}

// --
// helper
// --

/**
 * @summary Find all sources for graph specified with roots.
 * @param {Array of Node|Set of Node|Node} roots Array of roots.
 *
 * @function sourcesFromRoots
 * @return {Array of Node|Set of Node} Returns array with nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function sourcesFromRoots( dstContainer, srcContainer )
{
  let group = this;

  [ dstContainer, srcContainer ] = group._routineArguments( ... arguments );

  // if( srcContainer === dstContainer )
  // {
  //   debugger;
  //   srcContainer = dstContainer.make();
  //   dstContainer.empty();
  // }

  let tree = group.nodesStronglyConnectedTree( srcContainer );
  // debugger;
  tree.nodes.each( ( node ) =>
  {
    // debugger;
    if( tree.nodeIndegree( node ) === 0 )
    dstContainer.appendContainer( node.originalNodes );
  });
  // debugger;
  tree.finit();

  // let sources = group.ContainerMake();
  // let tree = group.nodesStronglyConnectedTree( nodes );
  // tree.nodes.forEach( ( node ) =>
  // {
  //   if( tree.nodeIndegree( node ) === 0 )
  //   _.arrayAppendArray( sources, node.originalNodes );
  // });
  // tree.finit();

  return dstContainer.original;
}

//

/**
 * @summary Find all nodes reachable from specified roots.
 * @param {Array of Node|Set of Node|Node} roots Array of roots.
 *
 * @function rootsAllReachable
 * @return {Array of Node|Set of Node} Returns array with nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function rootsAllReachable( dstRoots, srcRoots )
{
  let group = this;

  // if( group.nodeIs( dstRoots ) )
  // {
  //   dstRoots = group.nodesAs( dstRoots );
  // }
  //
  // if( srcRoots === undefined )
  // {
  //   if( dstRoots )
  //   srcRoots = dstRoots;
  //   else
  //   srcRoots = group.nodes;
  // }
  // else
  // {
  //   srcRoots = group.nodesAs( srcRoots );
  // }
  //
  // if( dstRoots === null )
  // dstRoots = _.MakeEmpty( srcRoots );
  // dstRoots = group.ContainerAdapterFrom( dstRoots );
  //
  // _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  // _.assert( group.ContainerIs( dstRoots ) );
  // _.assert( group.ContainerIs( srcRoots ) );

  // if( srcRoots === dstRoots )
  // srcRoots = _.make( dstRoots );

  [ dstRoots, srcRoots ] = group._routineArguments( ... arguments );

  group.lookDfs({ roots : srcRoots, onUp : onUp });

  return dstRoots.original;

  function onUp( node )
  {
    dstRoots.appendOnce( node );
  }

}

//

/**
 * @summary Find all nodes either reachable from specified roots or nodes which can reach specified.
 * @param {Array of Node|Set of Node|Node} roots Array of roots.
 *
 * @function rootsAll
 * @return {Array of Node|Set of Node} Returns array with sorted nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function rootsAll( dstRoots, srcRoots )
{
  let group = this;

  // if( group.nodeIs( dstRoots ) )
  // {
  //   dstRoots = group.nodesAs( dstRoots );
  // }
  //
  // if( srcRoots === undefined )
  // {
  //   if( dstRoots )
  //   srcRoots = dstRoots;
  //   else
  //   srcRoots = group.nodes;
  // }
  // else
  // {
  //   srcRoots = group.nodesAs( srcRoots );
  // }
  //
  // if( dstRoots === null )
  // dstRoots = _.MakeEmpty( srcRoots );
  // dstRoots = group.ContainerAdapterFrom( dstRoots );
  //
  // _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  // _.assert( group.ContainerIs( dstRoots ) );
  // _.assert( group.ContainerIs( srcRoots ) );

  [ dstRoots, srcRoots ] = group._routineArguments( ... arguments );

  // if( srcRoots === dstRoots )
  // srcRoots = _.make( dstRoots );

  group.lookDfs({ roots : srcRoots, onUp : onUp });

  return dstRoots.original;

  function onUp( node )
  {
    dstRoots.appendOnce( node );
  }

}

//

/**
 * @summary Put node in a container if not put yet in a container.
 * @param {Array|Set|Node} nodes Array of nodes.
 *
 * @function nodesAs
 * @return {Array|Set} Returns array with sorted nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodesAs( nodes )
{
  let group = this;

  if( group.ContainerIs( nodes ) )
  return nodes;

  _.assert( group.nodeIs( nodes ) );
  nodes = new Array( nodes );
  return nodes;
}

//

/**
 * @summary Put node in a set if not put yet in a container.
 * @param {Array|Set|Node} nodes Array of nodes.
 *
 * @function nodesAsSet
 * @return {Array|Set} Returns array with sorted nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodesAsSet( nodes )
{
  let group = this;

  if( group.ContainerIs( nodes ) )
  return nodes;

  _.assert( group.nodeIs( nodes ) );
  nodes = new Set([ nodes ]);
  return nodes;
}

//

/**
 * @summary Put node in a set if not put yet in a container.
 * @param {Array|Set|Node} nodes Array of nodes.
 *
 * @function nodesAsArray
 * @return {Array|Set} Returns array with sorted nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodesAsArray( nodes )
{
  let group = this;

  if( group.ContainerIs( nodes ) )
  return nodes;

  _.assert( group.nodeIs( nodes ) );
  nodes = new Array( nodes );
  return nodes;
}

//

/**
 * @summary Put node in a container if not put yet in a container. Put the containe in adapter.
 * @param {Array|Set|Node|ContainerAdapter} nodes Array of nodes.
 *
 * @function nodesAsAdapter
 * @return {ContainerAdapter} Returns array with sorted nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodesAsAdapter( nodes )
{
  let group = this;
  return group.ContainerAdapterFrom( group.nodesAs( nodes ) );
}

//

/**
 * @summary Check is argument allowed container either adapter of container.
 *
 * @function ContainerIs
 * @return {boolean} True if it is such thing.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function ContainerIs( src )
{
  if( _.arrayLike( src ) || _.setLike( src ) )
  return true;
  if( src instanceof ContainerAdapter )
  return true;
  return false;
}

//

/**
 * @summary Check is argument container adapter.
 *
 * @function ContainerIs
 * @return {boolean} True if it is such thing.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
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
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function OriginalOfAdapter( src )
{
  return ContainerAdapter.OriginalOf( src );
}

//

/**
 * @summary Make a new empty container for nodes.
 *
 * @function ContainerMake
 * @return {Container} Return new empty container for node. Empty Array by default.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function ContainerMake()
{
  _.assert( arguments.length === 0 );
  return new Array;
}

//

/**
 * @summary Make a new empty container for nodes and adapter for the container.
 *
 * @function ContainerAdapterMake
 * @return {ContainerAdapter} Return new empty container for node. Empty Array by default.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function ContainerAdapterMake()
{
  _.assert( arguments.length === 0 );
  return this.ContainerAdapterFrom( new Array );
}

//

/**
 * @summary Make adapter of a container for similar fast access to elements.
 *
 * @function ContainerAdapterFrom
 * @return {ContainerAdapter} Return ContainerAdapter not making a new one if passed in is such.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function ContainerAdapterFrom( container )
{
  _.assert( arguments.length === 1 );
  return _.containerAdapter.from( container );
  // if( container instanceof SetContainerAdapter || container instanceof ArrayContainerAdapter )
  // {
  //   return container;
  // }
  // else if( _.setIs( container ) )
  // {
  //   return new SetContainerAdapter( container );
  // }
  // else if( _.arrayIs( container ) )
  // {
  //   return new ArrayContainerAdapter( container );
  // }
  // else _.assert( 0, 'Unknown type of container' );
}

//

function _routineArguments( dstContainer, srcContainer )
{
  let group = this;

  if( group.nodeIs( dstContainer ) )
  {
    dstContainer = group.nodesAs( dstContainer );
  }

  if( srcContainer === undefined )
  {
    if( dstContainer )
    srcContainer = dstContainer;
    else
    srcContainer = group.nodes;
  }
  else
  {
    srcContainer = group.nodesAs( srcContainer );
  }

  srcContainer = group.ContainerAdapterFrom( srcContainer );

  if( dstContainer === null )
  dstContainer = _.MakeEmpty( srcContainer.original );
  dstContainer = group.ContainerAdapterFrom( dstContainer );

  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( group.ContainerIs( dstContainer ) );
  _.assert( group.ContainerIs( srcContainer ) );

  return [ dstContainer, srcContainer ]
}

// --
// traverser
// --

/**
 * @summary Performs breadth-first search on graph.
 * @param {Object} o Options map.
 * @param {Array|Object} o.roots Nodes to use as start point.
 * @param {Function} o.onUp Handler called before visiting each level.
 * @param {Function} o.onDown Handler called after visiting each level.
 * @param {Function} o.onNode Handler called for each node.
 *
 * @example
 * //define a graph of arbitrary structure
 *
 * var a = { name : 'a', nodes : [] } // 1
 * var b = { name : 'b', nodes : [] } // 2
 * var c = { name : 'c', nodes : [] } // 3
 * var d = { name : 'd', nodes : [] } // 4
 *
 * a.nodes.push( b,c ); // add connections between node a and b, c nodes
 * c.nodes.push( d ); // add connection between node c and d
 *
 * //declare the graph
 *
 * var sys = new _.graph.AbstractGraphSystem(); // declare sysyem of graphs
 * var group = sys.nodesGroup(); // declare group of nodes
 * group.nodesAdd([ a,b,c,d ]); // add nodes to the group
 *
 * // breadth-first search for reachable nodes using provided node as start point
 *
 * var layers = group.lookBfs({ roots : a }); // node 'a' is start node
 * layers = layers.map( ( nodes ) => group.nodesToNames( nodes ) ) // extract name of nodes from node handles to simplify the output
 * console.log( layers )
 *
 * @function lookBfs
 * @return {Array} Returns array of layers that are reachable from provided nodes `o.roots`.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function lookBfs( o )
{
  let group = this;

  _.routineOptions( lookBfs, o );

  o.roots = group.nodesAsSet( o.roots );
  o.roots = group.nodesAsAdapter( o.roots );

  if( o.revisiting < 3 && o.visitedContainer === null )
  o.visitedContainer = o.revisiting === 2 ? new Array() : new Set();
  if( o.visitedContainer )
  o.visitedContainer = group.ContainerAdapterFrom( o.visitedContainer );

  o.roots.once( o.roots );

  if( Config.debug )
  {
    _.assert( arguments.length === 1 );
    _.assert( group.nodesAreAll( o.roots ) );
    _.assert( 0 <= o.revisiting && o.revisiting <= 3 );
    _.assert( o.roots.all( ( node ) => group.nodeIs( node ) ) );
    _.assert( !o.visitedContainer || o.revisiting !== 2 || _.arrayIs( o.visitedContainer.original ) )
  }

  let iterator = Object.create( null );
  iterator.iterator = iterator;
  iterator.layers = [];
  iterator.level = 0;
  iterator.continue = true;
  iterator.continueUp = true;
  iterator.continueNode = true;
  iterator.result = iterator.layers;
  iterator.options = o;

  if( o.onBegin )
  o.onBegin( iterator );

  visit( o.roots, iterator );

  if( o.onEnd )
  o.onEnd( iterator );

  return iterator.result;

  /* */

  function visit( nodes, it )
  {
    let nodes2 = group.ContainerAdapterFrom( new Set );
    // let nodes2 = group.ContainerAdapterFrom( [] );
    // let nodesStatus = [];
    let nodesStatus = new HashMap;

    /*
      0 - not visiting
      1 - not including
      2 - not going up
      3 - visit, include, go up
    */

    if( o.onLayerUp )
    o.onLayerUp( nodes, it );

    let itContinueUp = it.continueUp;
    let itContinueNode = it.continueNode;

    if( it.iterator.continue )
    // nodes.every( ( node, k ) =>
    nodes.all( ( node, k ) =>
    {

      let visited;
      if( o.revisiting === 2 )
      {
        // visited = _.arrayCountElement( o.visitedContainer, node, group.onNodeEvaluate || undefined );
        visited = o.visitedContainer.count( node );
        if( visited > 1 )
        {
          // nodesStatus[ k ] = 0;
          nodesStatus.set( node, 0 );
          return true;
        }
      }
      else if( o.revisiting < 2 )
      {
        if( o.visitedContainer.has( node ) )
        // if( _.arrayHas( o.visitedContainer, node, group.onNodeEvaluate || undefined ) )
        {
          // nodesStatus[ k ] = 0;
          nodesStatus.set( node, 0 );
          return true;
        }
      }

      if( o.onUp )
      o.onUp( node, it );

      if( it.continueNode )
      if( o.onNode )
      o.onNode( node, it );

      if( !it.continueNode )
      it.continueUp = false;

      if( it.continueUp )
      {
        if( o.revisiting === 2 )
        {
          if( !visited )
          {
            nodes2.push( node );
          }
          if( o.visitedContainer )
          o.visitedContainer.push( node );
        }
        else
        {
          nodes2.push( node );
          if( o.visitedContainer )
          o.visitedContainer.push( node );
        }
      }

      if( it.continueUp )
      // nodesStatus[ k ] = 3;
      nodesStatus.set( node, 3 );
      else if( it.continueNode )
      // nodesStatus[ k ] = 2;
      nodesStatus.set( node, 2 );
      else
      // nodesStatus[ k ] = 1;
      nodesStatus.set( node, 1 );

      it.continueNode = itContinueNode;
      it.continueUp = itContinueUp;

      return it.iterator.continue;
    });

    it.continueUp = itContinueUp;
    it.continueNode = itContinueNode;

    if( !it.continueNode )
    it.continueUp = false;

    if( nodes2.length )
    {
      it.layers.push( nodes2.original );
      visitUp( nodes2, it );
    }

    /* */

    if( it.iterator.continue )
    nodes.all( ( node, k ) =>
    {

      // if( !nodesStatus[ k ] )
      if( !nodesStatus.get( node ) )
      return true;

      it.continueUp = true;
      it.continueNode = true;

      // if( nodesStatus[ k ] < 3 )
      if( nodesStatus.get( node ) < 3 )
      it.continueUp = false;
      // if( nodesStatus[ k ] < 2 )
      if( nodesStatus.get( node ) < 2 )
      it.continueNode = false;

      if( o.onDown )
      o.onDown( node, it );

      return true;
    });

    if( o.onLayerDown )
    o.onLayerDown( nodes2, it );

    it.continueUp = true;
  }

  /* */

  function visitUp( nodes2, it )
  {
    let nodes3 = group.ContainerAdapterFrom( new Set );

    if( !it.iterator.continue || !it.continueUp )
    return;

    nodes2.each( ( node ) =>
    {
      let outNodes = group.nodeOutNodesFor( node );
      // _.arrayAppendArray( nodes3, outNodes );
      // nodes3.appendContainer( outNodes );
      nodes3.appendContainerOnce( outNodes );
      // return true;
    });

    let level = it.level;
    let continueNode = it.continueNode;
    it.level += 1;
    visit( nodes3, it );
    it.level = level;
    it.continueNode = continueNode;

  }

}

lookBfs.defaults =
{

  roots : null,
  visitedContainer : null,

  revisiting : 0,
  fast : 1,

  onBegin : null,
  onEnd : null,
  onNode : null,
  onUp : null,
  onDown : null,
  onLayerUp : null,
  onLayerDown : null,

}

//

/**
 * @summary Performs depth-first search on graph.
 * @param {Object} o Options map.
 * @param {Array|Object} o.roots Nodes to use as start point.
 * @param {Function} o.onUp Handler called before visiting each level.
 * @param {Function} o.onDown Handler called after visiting each level.
 *
 * @example
 * //define a graph of arbitrary structure
 *
 * var a = { name : 'a', nodes : [] } // 1
 * var b = { name : 'b', nodes : [] } // 2
 * var c = { name : 'c', nodes : [] } // 3
 * var d = { name : 'd', nodes : [] } // 4
 *
 * a.nodes.push( b,c ); // add connections between node a and b, c nodes
 * c.nodes.push( d ); // add connection between node c and d
 *
 * //declare the graph
 *
 * var sys = new _.graph.AbstractGraphSystem(); // declare sysyem of graphs
 * var group = sys.nodesGroup(); // declare group of nodes
 * group.nodesAdd([ a,b,c,d ]); // add nodes to the group
 *
 * // breadth-first search for reachable nodes using provided node as start point
 *
 * var layers = group.lookDfs({ roots : a }); // node 'a' is start node
 * layers = layers.map( ( nodes ) => group.nodesToNames( nodes ) ) // extract name of nodes from node handles to simplify the output
 * console.log( layers )
 *
 * @function lookDfs
 * @return {Array} Returns array of layers that are reachable from provided nodes `o.roots`.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function lookDfs( o )
{
  let group = this;

  _.routineOptions( lookDfs, o );

  o.roots = group.nodesAsAdapter( o.roots );

  if( o.revisiting < 3 && o.visitedContainer === null )
  o.visitedContainer = group.ContainerMake();
  if( o.visitedContainer )
  o.visitedContainer = group.ContainerAdapterFrom( o.visitedContainer );

  _.assert( arguments.length === 1 );
  _.assert( 0 <= o.revisiting && o.revisiting <= 3 );

  let iterator = Object.create( null );
  iterator.iterator = iterator;
  iterator.continue = true;
  iterator.continueUp = true;
  iterator.result = null;
  iterator.level = 0;
  iterator.options = o;
  iterator.visited = false;
  iterator.continueNode = true;

  if( o.onBegin )
  o.onBegin( iterator );

  if( o.fast )
  {
    o.roots.all( ( node, index ) =>
    {
      iterator.node = node;
      iterator.index = index;
      visitFast( iterator )
      return iterator.continue;
    });
  }
  else
  {
    o.roots.all( ( node, index ) =>
    {
      let it = Object.create( iterator );
      it.prev = iterator;
      it.node = node;
      it.index = index;
      it.visited = false;
      it.continueNode = true;
      it.level = 0;
      visitSlow( it );
      return it.iterator.continue;
    });
  }

  if( o.onEnd )
  o.onEnd( iterator );

  return iterator.result;

  /* */

  function visitSlow( it )
  {

    if( o.revisiting < 3 )
    if( o.visitedContainer.has( it.node ) )
    {
      if( o.revisiting < 2 )
      return;
      it.continueUp = false;
      it.visited = true;
    }

    if( o.visitedContainer )
    o.visitedContainer.push( it.node );

    if( o.onUp )
    o.onUp( it.node, it );

    if( o.onNode )
    if( it.continueNode )
    o.onNode( it.node, it );

    if( !it.continueNode )
    {
      it.continueUp = false;

      if( o.visitedContainer )
      if( o.revisiting !== 1 || o.revisiting !== 2 )
      o.visitedContainer.pop( it.node );

    }

    let level = it.level + 1;

    if( it.iterator.continue && it.continueUp )
    {
      debugger;
      let outNodes = group.nodeOutNodesFor( it.node );
      // for( let n = 0 ; n < outNodes.length ; n++ )
      outNodes.each( ( node, n ) =>
      {

        // let node = outNodes[ n ];
        let it2 = Object.create( iterator );
        it2.node = node;
        it2.index = n;
        it2.prev = it;
        it2.level = level;
        it2.visited = false;
        it2.continueNode = true;

        visitSlow( it2 );
        _.assert( !_.mapOwnKey( it2, 'continue' ) );
      });
    }

    if( o.onDown )
    o.onDown( it.node, it );

    if( o.revisiting === 1 || o.revisiting === 2 )
    {
      o.visitedContainer.pop( it.node );
    }

  }

  /* */

  function visitFast( it )
  {
    if( o.revisiting < 3 )
    if( o.visitedContainer.has( it.node ) )
    {
      if( o.revisiting < 2 )
      return;
      it.continueUp = false;
      it.visited = true;
    }

    if( o.visitedContainer )
    o.visitedContainer.push( it.node );

    if( o.onUp )
    o.onUp( it.node, it );

    if( o.onNode )
    if( it.continueNode )
    o.onNode( it.node, it );

    if( !it.continueNode )
    {
      it.continueUp = false;

      if( o.visitedContainer )
      if( o.revisiting !== 1 || o.revisiting !== 2 )
      o.visitedContainer.pop( it.node );

    }

    if( it.iterator.continue && it.continueUp )
    {
      let level = it.level;
      let node = it.node;
      let index = it.index;
      let visited = it.visited;
      let outNodes = group.nodeOutNodesFor( it.node );

      // for( let n = 0 ; n < outNodes.length ; n++ )
      outNodes.all( ( node, n ) =>
      {
        // it.node = outNodes[ n ];
        it.node = node;
        it.index = n;
        it.level = level + 1;
        it.visited = false;
        visitFast( it );
        // if( !it.iterator.continue )
        // return false;
        // break;
        return it.iterator.continue;
      });

      it.level = level;
      it.node = node;
      it.index = index;
      it.visited = visited;
    }

    if( o.onDown )
    o.onDown( it.node, it );

    if( o.revisiting === 1 || o.revisiting === 2 )
    {
      o.visitedContainer.pop( it.node );
    }

    it.continueNode = true;
    it.continueUp = true;
  }

}

lookDfs.defaults =
{

  roots : null,
  visitedContainer : null,

  revisiting : 0,
  fast : 1,

  onBegin : null,
  onEnd : null,
  onNode : null,
  onUp : null,
  onDown : null,

}

//

function lookDbfs( o )
{
  let group = this;

  _.routineOptions( lookDbfs, o );

  o.roots = group.nodesAsAdapter( o.roots );
  if( o.revisiting < 3 && o.visitedContainer === null )
  o.visitedContainer = group.ContainerMake();
  if( o.visitedContainer )
  o.visitedContainer = group.ContainerAdapterFrom( o.visitedContainer );

  if( Config.debug )
  {
    _.assert( arguments.length === 1 );
    _.assert( 0 <= o.revisiting && o.revisiting <= 3 );
    _.assert( group.nodesAreAll( o.roots ) );
  }

  let iterator = Object.create( null );
  iterator.iterator = iterator;
  iterator.continue = true;
  iterator.continueUp = true;
  iterator.visited = false;
  iterator.continueNode = true;
  iterator.result = null;
  iterator.level = 0;
  iterator.options = o;

  if( o.onBegin )
  o.onBegin( iterator );

  o.roots.all( ( node, index ) =>
  {
    iterator.node = node;
    iterator.index = index;
    visitFirstFast( iterator );
    visitSecondFast( iterator );
    return iterator.continue;
  });

  if( o.onEnd )
  o.onEnd( iterator );

  return iterator.result;

  /* */

  function visitSecondFast( it )
  {

    if( o.visitedContainer )
    if( o.revisiting === 1 || o.revisiting === 2 )
    o.visitedContainer.push( it.node );

    if( it.iterator.continue && it.continueUp )
    {
      let level = it.level;
      let node = it.node;
      let index = it.index;
      let visited = it.visited;

      let outNodes = group.nodeOutNodesFor( it.node );
      let nodesStatus = new HashMap;
      // let status = [];
      /*
        0 - not visiting
        1 - not including
        2 - not going up
        3 - visit, include, go up
      */

      // for( let n = 0 ; n < outNodes.length ; n++ )
      outNodes.all( ( node, n ) =>
      {

        // let node = outNodes[ n ];
        // status[ n ] = 3;
        nodesStatus.set( node, 3 )

        // if( o.revisiting < 3 )
        // if( _.arrayHas( o.visitedContainer, node ) )
        // status[ n ] = _.arrayHas( o.visitedContainer, node ) ? 0 : 3;
        if( o.revisiting < 3 )
        // if( _.arrayHas( o.visitedContainer, node, group.onNodeEvaluate || undefined ) )
        if( o.visitedContainer.has( node ) )
        nodesStatus.set( node, 0 )
        // status[ n ] = 0;

        // if( o.revisiting < 2 && !status[ n ] )
        if( o.revisiting < 2 && !nodesStatus.get( node ) )
        return true;
        // continue;

        it.level = level+1;
        // it.node = outNodes[ n ];
        it.node = node;
        it.index = n;
        it.visited = false;
        // if( o.revisiting === 2 && !status[ n ] )
        if( o.revisiting === 2 && !nodesStatus.get( node ) ) /* xxx : optmize */
        {
          it.visited = true;
          it.continueUp = false;
        }

        visitFirstFast( it );

        if( nodesStatus.get( node ) > 1 && !it.continueNode )
        nodesStatus.set( node, 1 );
        if( nodesStatus.get( node ) > 2 && !it.continueUp )
        nodesStatus.set( node, 2 );

        // if( status[ n ] > 1 && !it.continueNode )
        // status[ n ] = 1;
        // if( status[ n ] > 2 && !it.continueUp )
        // status[ n ] = 2;

        if( !it.iterator.continue )
        return false;

        it.continueNode = true;
        it.continueUp = true;

        return true;
      });

      // for( let n = 0 ; n < outNodes.length ; n++ )
      outNodes.all( ( node, n ) =>
      {
        // if( o.revisiting < 2 && !status[ n ] )
        if( o.revisiting < 2 && !nodesStatus.get( node ) )
        return true;
        // continue;

        it.level = level+1;
        it.index = n;
        // it.node = outNodes[ n ];
        it.node = node;
        // it.visited = status[ n ] > 0;
        // it.continueNode = status[ n ] > 1;
        // it.continueUp = status[ n ] > 2;

        it.visited = nodesStatus.get( node ) > 0;
        it.continueNode = nodesStatus.get( node ) > 1;
        it.continueUp = nodesStatus.get( node ) > 2;

        visitSecondFast( it );
        if( !it.iterator.continue )
        return false;
        // break;
        return true;
      });

      it.level = level;
      it.node = node;
      it.index = index;
      it.visited = visited;
    }

    if( o.onDown )
    o.onDown( it.node, it );

    if( o.revisiting === 1 || o.revisiting === 2 )
    {
      // _.assert( o.visitedContainer[ o.visitedContainer.length-1 ] === it.node );
      // o.visitedContainer.pop( it.node );
      o.visitedContainer.popStrictly( it.node );
    }

    it.continueNode = true;
    it.continueUp = true;
  }

  /* */

  function visitFirstFast( it )
  {

    if( o.visitedContainer )
    if( o.revisiting !== 1 && o.revisiting !== 2 )
    o.visitedContainer.push( it.node );

    if( o.onUp )
    o.onUp( it.node, it );

    if( it.continueNode )
    if( o.onNode )
    o.onNode( it.node, it );

    if( !it.continueNode )
    {
      it.continueUp = false;
      if( o.visitedContainer )
      if( o.revisiting !== 1 || o.revisiting !== 2 )
      o.visitedContainer.pop();
    }

  }

}

lookDbfs.defaults =
{

  roots : null,
  visitedContainer : null,

  revisiting : 0,
  fast : 1,

  onBegin : null,
  onEnd : null,
  onNode : null,
  onUp : null,
  onDown : null,

}

// --
// orderer
// --

/**
 * @summary Algorithm of linear ordering of directed acycled graph. Based on depth-first search.
 * @param {Array} nodes Array of nodes.
 *
 * @example
 * //define a graph of arbitrary structure
 *
 * var a = { name : 'a', nodes : [] } // 1
 * var b = { name : 'b', nodes : [] } // 2
 * var c = { name : 'c', nodes : [] } // 3
 * var d = { name : 'd', nodes : [] } // 4
 *
 * a.nodes.push( b,c );
 * c.nodes.push( d );
 *
 * //declare the graph
 *
 * var sys = new _.graph.AbstractGraphSystem(); // declare sysyem of graphs
 * var group = sys.nodesGroup(); // declare group of nodes
 * group.nodesAdd([ a,b,c,d ]); // add nodes to the group
 *
 * //topological sort based on depth first search
 *
 * var ordering = group.dagTopSortDfs();
 * ordering = ordering.map( ( nodes ) => group.nodesToNames( nodes ) ); // get names of nodes to simplify output
 * console.log( ordering );
 *
 * //[ 'b', 'd', 'c', 'a' ]
 *
 * @function dagTopSortDfs
 * @return {Array} Returns array with sorted nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function dagTopSortDfs( nodes )
{
  let group = this;
  let ordering = [];
  // let visitedContainer = group.ContainerMake(); // xxx : remove extra container?
  let visitedContainer = group.ContainerAdapterFrom( new Set );

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodes ) );

  nodes.each( ( node ) =>
  {
    // if( _.arrayHas( visitedContainer, node, group.onNodeEvaluate || undefined ) )
    if( visitedContainer.has( node ) )
    return;
    group.lookDfs({ roots : node, onDown : handleDown, revisiting : 0 });
  });

  _.assert( ordering.length === nodes.length, 'Seems input graph is not a DAG' );

  return ordering;

  /* */

  function handleDown( node, it )
  {
    let outNodes = group.nodeOutNodesFor( node );
    // outNodes = outNodes.filter( ( node2 ) => !_.arrayHas( visitedContainer, node2, group.onNodeEvaluate || undefined ) );
    outNodes = outNodes.filter( ( node2 ) => !visitedContainer.has( node2 ) ? node2 : undefined );
    if( outNodes.length === 0 )
    ordering.push( node );
    visitedContainer.push( node );
  }

}

//

function each_pre( routine, args )
{
  let group = this;
  let o = args[ 0 ];

  _.assert( arguments.length === 2 );
  _.assert( 0 <= args.length && args.length <= 2 );
  _.assert( args[ 1 ] === undefined || _.routineIs( args[ 1 ] ) )

  if( _.routineIs( args[ 0 ] ) && args[ 1 ] === undefined )
  o = { onUp : args[ 0 ] };
  else if( _.routineIs( args[ 1 ] ) )
  o = { nodes : args[ 0 ], onUp : args[ 1 ] };
  else if( o === undefined )
  o = {};

  _.routineOptions( routine, o );

  if( o.result === null )
  o.result = [];
  o.result = group.nodesAsAdapter( o.result );

  if( o.roots === undefined || o.roots === null )
  o.roots = group.nodes;
  else
  o.roots = group.nodesAsAdapter( o.roots );

  if( Config.debug )
  {
    _.assert( 0 <= o.recursive && o.recursive <= 2 );
    _.assert( 0 <= o.revisiting && o.revisiting <= 3 );
    _.assert( group.nodesAreAll( o.roots ) );
  }

  if( o.method === null )
  o.method = this.lookDbfs;
  if( _.strIs( o.method ) )
  {
    _.assert( _.routineIs( this[ o.method ] ), () => 'Unknown method ' + _.strQuote( o.method ) );
    o.method = this[ o.method ];
  }
  _.assert
  (
    _.routineIs( o.method ),
    () => 'Expects routine {- o.method -} either lookBfs, lookDfs, lookDbfs, but got' + _.strType( o.method )
  );
  _.assert
  (
    o.method === group.lookBfs || o.method === group.lookDfs || o.method === group.lookDbfs ,
    () => 'Expects routine {- o.method -} either lookBfs, lookDfs, lookDbfs, but got' + _.strType( o.method )
  );

  return o;
}

function each_body( o )
{
  let group = this;

  _.assertRoutineOptions( each, o );

  let o2 = _.mapOnly( o, o.method.defaults );

  o2.onNode = handleNode;
  o2.onUp = handleUp;
  o2.onDown = handleDown;
  o2.onBegin = handleBegin;
  o2.onEnd = handleEnd;

  let r = o.method.call( group, o2 );

  return o.result.original;

  /* */

  function handleNode( node, it )
  {

    if( o.onNode )
    o.onNode.apply( this, arguments );

    if( it.included )
    o.result.append( node );

    // if( it.included )
    // _.arrayAppend( o.result, node );

  }

  function handleUp( node, it )
  {
    it.included = true;

    // console.log( 'handleUp', node.name ); debugger;

    if( o.recursive === 0 )
    {
      it.continueUp = 0;
    }
    else if( o.recursive === 1 )
    {
      if( it.level > 0 )
      it.continueUp = 0;
    }

    if( it.included )
    if( !o.withStem && it.level === 0 )
    it.included = false;
    if( it.included )
    if( !o.includingBranches || !o.withTerminals )
    {
      let degree = group.nodeOutdegree( node );
      if( !o.includingBranches && degree > 0 )
      it.included = false;
      if( !o.withTerminals && degree === 0 )
      it.included = false;
    }

    if( o.onUp )
    o.onUp.apply( this, arguments );
  }

  function handleDown( node, it )
  {
    if( o.onDown )
    o.onDown.apply( this, arguments );
  }

  function handleBegin( it )
  {
    if( o.onBegin )
    o.onBegin.apply( this, arguments );
  }

  function handleEnd( it )
  {

    if( o.mandatory )
    if( !o.result.length )
    throw _.err( 'Found none node, but {- o.mandatory : 1 -}' );

    if( o.onEnd )
    o.onEnd.apply( this, arguments );
  }

}

var defaults = each_body.defaults = Object.create( lookDfs.defaults )

defaults.result = null;
defaults.method = null;

defaults.mandatory = 0;
defaults.recursive = 2;
defaults.withStem = 1;
defaults.withTerminals = 1;
defaults.includingBranches = 1;

let each = _.routineFromPreAndBody( each_pre, each_body );

let eachBfs = _.routineFromPreAndBody( each_pre, each_body );
var defaults = eachBfs.defaults;
defaults.method = lookBfs;

let eachDfs = _.routineFromPreAndBody( each_pre, each_body );
var defaults = eachDfs.defaults;
defaults.method = lookDfs;

let eachDbfs = _.routineFromPreAndBody( each_pre, each_body );
var defaults = eachDbfs.defaults;
defaults.method = lookDbfs;

//

/**
 * @summary Algorithm of linear ordering of directed acycled graph. Based on breadth-first search.
 * @description
 * Performs ordering using nodes with zero indegree.
 * Uses nodes of current group if `nodes` argument is not provided.
 * @param {Array} [nodes] Array of nodes.
 *
 * @example
 *
 * // define a graph of arbitrary structure
 * var a = { name : 'a', nodes : [] } // 1
 * var b = { name : 'b', nodes : [] } // 2
 * var c = { name : 'c', nodes : [] } // 3
 * var d = { name : 'd', nodes : [] } // 4
 *
 * a.nodes.push( b,c );
 * c.nodes.push( d );
 *
 * // declare the graph
 *
 * var sys = new _.graph.AbstractGraphSystem(); // declare sysyem of graphs
 * var group = sys.nodesGroup(); // declare group of nodes
 * group.nodesAdd([ a,b,c,d ]); // add nodes to the group
 *
 * // topological sort based on depth first search
 *
 * var ordering = group.topSortSourceBasedBfs();
 * ordering = ordering.map( ( nodes ) => group.nodesToNames( nodes ) ); // get names of nodes to simplify output
 * console.log( ordering );
 *
 * //
 * //[
 * //  [ 'a' ],
 * //   [ 'b', 'c' ],
 * //  [ 'd' ]
 * //]
 *
 * @function topSortSourceBasedBfs
 * @return {Array} Returns array with sorted layers.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function topSortSourceBasedBfs( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  let sources = group.leastIndegreeOnlyAmong( nodes );
  let result = group.lookBfs({ roots : sources });

  return result;
}

//

function topSortCycledSourceBasedBfs( nodes )
{
  let group = this;

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !nodes.length )
  return group.ContainerMake();

  /* xxx : use method instead */

  debugger;
  let sources = group.ContainerMake();
  let tree = group.nodesStronglyConnectedTree( nodes );
  tree.nodes.each( ( node ) =>
  {
    if( tree.nodeIndegree( node ) === 0 )
    sources.appendContainer( node.originalNodes );
    // _.arrayAppendArray( sources, node.originalNodes );
  });
  tree.finit();

  _.assert( sources.length > 0 );

  let result = group.lookBfs({ roots : sources });

  debugger; xxx
  return _.arrayFlatten( null, result ); // xxx
}

// --
// connectivity
// --

/**
 * @summary Returns path from the second node to the first.
 * @description Performs check using DFS algorithm.
 * @returns {Array of Node} Returns array of nodes.
 * @param {Pair of Node} pair Pair o nodes.
 * @function pairDirectedPathGetDfs
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function pairDirectedPathGetDfs( pair )
{
  let group = this;

  _.assert( _.pair.is( pair ), 'Expects pair of nodes' );
  _.assert( arguments.length === 1 );

  let visited = new Set();
  let visitedAdapter = group.ContainerAdapterFrom( visited );
  let node1 = pair[ 0 ];
  let node2 = pair[ 1 ];
  let found = false;
  let result = [];

  _.assert( !!group.nodeIs( node1 ) );
  _.assert( !!group.nodeIs( node2 ) );

  console.log( '-' );

  group.lookDfs
  ({
    roots : node2,
    visitedContainer : visitedAdapter,
    onUp : onUp1,
    onDown : onDown1,
  });

  if( found )
  return result;
  return false;

  /* */

  function onUp1( node, it )
  {

    console.log( 'onUp1', node.name );

    if( found )
    {
      it.continueNode = false;
      return;
    }

    if( node === node1 )
    {
      it.continueUp = false;
      found = true;
    }

  }

  /* */

  function onDown1( node, it )
  {

    if( found && it.continueNode )
    {
      result.unshift( node );
    }

  }

}

//

/**
 * @summary Returns true if path from the second node to the first exists.
 * @description Performs check using DFS algorithm.
 * @returns {boolean} Returns true if exists.
 * @param {Pair of Node} pair Pair o nodes.
 * @function pairDirectedPathExistsDfs
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function pairDirectedPathExistsDfs( pair )
{
  let group = this;

  _.assert( _.pair.is( pair ), 'Expects pair of nodes' );
  _.assert( arguments.length === 1 );

  let visited = new Set();
  let visitedAdapter = group.ContainerAdapterFrom( visited );
  let node1 = pair[ 0 ];
  let node2 = pair[ 1 ];
  let found = false;

  _.assert( !!group.nodeIs( node1 ) );
  _.assert( !!group.nodeIs( node2 ) );

  group.lookDfs
  ({
    roots : node2,
    visitedContainer : visitedAdapter,
    onUp : onUp1,
  });

  return found;

  /* */

  function onUp1( node, it )
  {

    if( found )
    {
      it.continueNode = false;
      return;
    }

    if( node === node1 )
    {
      it.continueUp = false;
      found = true;
    }

  }

}

//

/**
 * @summary Returns true if two nodes are connected.
 * @description Performs check using DFS algorithm.
 * @param {Object} node1 First node.
 * @param {Object} node2 Second node.
 * @function pairIsConnectedDfs
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function pairIsConnectedDfs( pair )
{
  let group = this;

  _.assert( _.pair.is( pair ), 'Expects pair of nodes' );
  _.assert( arguments.length === 1 );

  let visited = new Set();
  let visitedAdapter = group.ContainerAdapterFrom( visited );
  let node1 = pair[ 0 ];
  let node2 = pair[ 1 ];

  _.assert( !!group.nodeIs( node1 ) );
  _.assert( !!group.nodeIs( node2 ) );

  let r = group.lookDfs
  ({
    roots : node1,
    visitedContainer : visitedAdapter,
    onUp : onUp1,
    onBegin,
  });

  if( r )
  return true;

  return group.lookDfs
  ({
    roots : node2,
    revisiting : 0,
    visitedContainer : new Set(),
    onUp : onUp2,
    onBegin,
  });

  /* */

  function onBegin( iterator )
  {
    iterator.result = false;
  }

  /* */

  function onUp1( node, it )
  {

    if( node === node2 )
    {
      it.iterator.continue = false;
      it.result = true;
    }

  }

  /* */

  function onUp2( node, it )
  {

    if( node === node1 || visitedAdapter.has( node ) )
    {
      it.iterator.continue = false;
      it.result = true;
    }

  }

}

//

/**
 * @summary Returns true if two nodes are connected strongly.
 * @description Performs check using DFS algorithm.
 * @param {Object} node1 First node.
 * @param {Object} node2 Second node.
 * @function pairIsConnectedStronglyDfs
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function pairIsConnectedStronglyDfs( pair )
{
  let group = this;

  _.assert( _.pair.is( pair ), 'Expects pair of nodes' );
  _.assert( arguments.length === 1 );

  let visited = new Set();
  let visitedAdapter = group.ContainerAdapterFrom( visited );
  let node1 = pair[ 0 ];
  let node2 = pair[ 1 ];

  _.assert( !!group.nodeIs( node1 ) );
  _.assert( !!group.nodeIs( node2 ) );

  let r = group.lookDfs
  ({
    roots : node1,
    visitedContainer : visitedAdapter,
    onUp : onUp1,
    onBegin,
  });

  if( !r )
  return false;

  return group.lookDfs
  ({
    roots : node2,
    revisiting : 0,
    visitedContainer : new Set(),
    onUp : onUp2,
    onBegin,
  });

  /* */

  function onBegin( iterator )
  {
    iterator.result = false;
  }

  /* */

  function onUp1( node, it )
  {

    if( node === node2 )
    {
      it.iterator.continue = false;
      it.result = true;
    }

  }

  /* */

  function onUp2( node, it )
  {

    // if( node === node1 || _.arrayHas( visited, node ) )
    if( node === node1 || visitedAdapter.has( node ) )
    {
      it.iterator.continue = false;
      it.result = true;
    }

  }

}

//

/**
 * @summary Group connected nodes.
 * @description Performs look using DFS algorithm.
 * @param {Array} nodes Array with node descriptors.]
 *
 * @example
 *
 * //define a graph of arbitrary structure
 *
 * var a = { name : 'a', nodes : [] } // 1
 * var b = { name : 'b', nodes : [] } // 2
 * var c = { name : 'c', nodes : [] } // 3
 * var d = { name : 'd', nodes : [] } // 4
 *
 * a.nodes.push( b,c );
 * c.nodes.push( d );
 *
 * // declare the graph
 *
 * var sys = new _.graph.AbstractGraphSystem(); // declare sysyem of graphs
 * var group = sys.nodesGroup(); // declare group of nodes
 * group.nodesAdd([ a,b,c,d ]); // add nodes to the group
 *
 * // checking if nodes are connected using DFS algorithm
 *
 * var connected = group.pairIsConnectedDfs( a, d );
 * console.log( 'Nodes a and d are connected:', connected )
 *
 * var connected = group.pairIsConnectedDfs( b, d );
 * console.log( 'Nodes b and d are connected:', connected )
 *
 * // group connected nodes
 *
 * c.nodes = []; // break connection between c and d nodes
 * d.nodes.push( c ); // connect d and c nodes to make second group
 * var connectedNodes = group.nodesConnectedLayers();
 * console.log( 'Nodes grouped by connectivity:', connectedNodes )
 *
 * //[
 * //   a  b  c      d  c
 * //  [ 1, 2, 3 ], [ 4, 3 ]
 * //]
 *
 * @function nodesConnectedLayersDfs
 * @returns {Array} Returns array of arrays. Each inner array contains ids of connected nodes.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractNodesGroup#
 */

function nodesConnectedLayersDfs( nodes )
{
  let group = this;
  let groups = [];
  let visitedContainer = group.ContainerMake(); /* xxx : remove extra container, refactor */

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodes ) );

  nodes.each( ( node ) =>
  {
    // let id = group.nodeToId( node );
    // if( _.arrayHas( visitedContainer, id ) )
    if( o.visitedContainer.has( node ) )
    return;
    groups.push( [] );
    group.lookDfs({ roots : node, onUp : handleUp });
  });

  return groups;

  /* */

  function handleUp( node, it )
  {
    debugger;
    // let id = group.nodeToId( node ); // xxx : check
    visitedContainer.push( node );
    groups[ groups.length-1 ].push( node );
  }

}

//

function nodesStronglyConnectedLayersDfs( nodes )
{
  let group = this;
  let sys = group.sys;
  let visited1 = [];
  let visited2 = group.ContainerMake();
  let layers = [];

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodes ) );

  /* mark */

  if( group.direct && !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce( nodes );

  group.reverse();

  nodes.each( ( node ) =>
  {
    // if( _.arrayHas( visited1, node, group.onNodeEvaluate || undefined ) )
    if( visited1.has( node ) )
    return;
    /*
      both visited1 and visitedContainer made with revisiting : 0 are required
      visitedContainer ( filled by DFS ) tracks visited nodes on up
      visited1 tracks visited nodes on down
      third container visited2 filled by DFS
    */
    group.lookDfs
    ({
      roots : [ node ],
      onUp :
      handleUp1,
      onDown : handleDown1,
      revisiting : 0,
    });
  });

  /* collect layers */

  group.reverse();

  // for( let i = visited1.length-1 ; i >= 0 ; i-- )
  visited.each( ( node, i ) =>
  {
    // let node = visited1[ i ];
    // if( _.arrayHas( visited2, node, group.onNodeEvaluate || undefined ) )
    if( visited2.has( node ) )
    return;
    // continue;
    let layer = [];
    layers.push( layer );
    group.lookDfs
    ({
      roots : [ node ],
      onUp : handleUp2_functor( layer ),
      visitedContainer : visited2,
      revisiting : 0,
    });
  });

  /* */

  return layers;

  /* */

  function handleUp1( node, it )
  {
    // if( _.arrayHas( visited1, node, group.onNodeEvaluate || undefined ) )
    if( visited1.has( node ) )
    {
      it.continueUp = false;
      return;
    }
  }

  /* */

  function handleDown1( node, it )
  {
    if( !it.continueUp )
    return;
    visited1.push( node );
  }

  /* */

  function handleUp2_functor( layer )
  {
    return function handleUp2( node, it )
    {
      _.assert( visited1.has( node ), () => `Input set of nodes does not have ${group.nodeToQualifiedNameTry( node )}` );
      // _.assert( _.arrayHas( visited1, node, group.onNodeEvaluate || undefined ), () => 'Input set of nodes does not have a node ' + group.nodeToName( node ) );
      layer.push( node );
    }
  }

}

//

function nodesStronglyConnectedTreeDfs( nodes )
{
  let group = this;
  let sys = group.sys;
  let visited1 = group.ContainerAdapterFrom( [] );
  let visited2 = group.ContainerAdapterFrom( new Set );
  let fromOriginal = new HashMap();

  if( nodes === undefined )
  nodes = group.nodes;
  else
  nodes = group.nodesAsAdapter( nodes )

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( group.nodesAreAll( nodes ) );

  /* mark */

  if( group.direct && !group.onInNodesGet )
  group.cacheInNodesFromOutNodesOnce( nodes );

  group.reverse();

  nodes.each( ( node ) =>
  {
    // if( _.arrayHas( visited1, node, group.onNodeEvaluate || undefined ) )
    if( visited1.has( node ) )
    return;
    /*
      both visited1 and visitedContainer made with revisiting : 0 are required
      visitedContainer ( filled by DFS ) tracks visited nodes on up
      visited1 tracks visited nodes on down
      third container visited2 filled by DFS
    */
    group.lookDfs
    ({
      roots : [ node ],
      onUp :
      handleUp1,
      onDown : handleDown1,
      revisiting : 0,
    });
  });

  /* make new graph */

  let group2 = sys.nodesGroup
  ({
    onNodeNameGet : group.nodeNameFromGetterId,
    onOutNodesGet : group.nodesFromFieldOutNodes,
    onInNodesGet : group.nodesFromFieldInNodes,
  });

  /* collect layers */

  group.reverse();

  // for( let i = visited1.length-1 ; i >= 0 ; i-- )
  visited1.eachRight( ( node, i ) =>
  {
    // let node = visited1[ i ];
    // if( _.arrayHas( visited2, node, group.onNodeEvaluate || undefined ) )
    if( visited2.has( node ) )
    return;
    // continue;
    let dnode = dnodeMake();
    group.lookDfs
    ({
      roots : [ node ],
      onUp : handleUp2_functor( dnode ),
      visitedContainer : visited2,
      revisiting : 0,
    });
  });

  /* add edges */

  // for( let l = 0 ; l < group2.nodes.length ; l++ )
  group2.nodes.each( ( dnode, l ) =>
  {
    // let dnode = group2.nodes[ l ];
    // for( let t = 0 ; t < dnode.originalOutNodes.length ; t++ )
    dnode.originalOutNodes.each( ( node, t ) =>
    {
      // let node = dnode.originalOutNodes[ t ];
      // if( _.arrayHas( dnode.originalNodes, originalOutId ) )
      if( dnode.originalNodes.has( node ) )
      return;
      // continue;
      let dnode2 = fromOriginal.get( node );
      dnode.outNodes.appendOnce( dnode2 );
      dnode2.inNodes.appendOnce( dnode );
      // _.arrayAppendOnce( dnode.outNodes, dnode2 );
      // _.arrayAppendOnce( dnode2.inNodes, dnode );
    });
  });

  /* */

  return group2;

  /* */

  function dnodeMake()
  {
    let dnode = Object.create( null );
    // debugger;
    dnode.inNodes = group2.ContainerAdapterFrom( new Set ); // xxx : use sets
    dnode.outNodes = group2.ContainerAdapterFrom( new Set );
    dnode.originalNodes = group2.ContainerAdapterFrom( new Set );
    dnode.originalOutNodes = group2.ContainerAdapterFrom( new Set );
    group2.nodeAdd( dnode );
    return dnode;
  }

  /* */

  function handleUp1( node, it )
  {
    // if( _.arrayHas( visited1, node, group.onNodeEvaluate || undefined ) )
    if( visited1.has( node ) )
    {
      it.continueUp = false;
      return;
    }
  }

  /* */

  function handleDown1( node, it )
  {
    if( !it.continueUp )
    return;
    visited1.push( node );
    // _.assert( _.arrayHas( nodes, node ), `Expects container with all nodes, but ${group.nodeToQualifiedName( node )} is not in the container` );
    _.assert( nodes.has( node ), () => `Input set of nodes does not have ${group.nodeToQualifiedNameTry( node )}` );
  }

  /* */

  function handleUp2_functor( dnode )
  {
    return function handleUp2( node, it )
    {
      _.assert( visited1.has( node ), () => `Input set of nodes does not have ${group.nodeToQualifiedNameTry( node )}` );
      // _.assert( _.arrayHas( visited1, node, group.onNodeEvaluate || undefined ), () => 'Input set of nodes does not have a node ' + group.nodeToName( node ) );
      fromOriginal.set( it.node, dnode );
      dnode.originalNodes.push( node );
      dnode.originalOutNodes.appendContainer( group.nodeOutNodesFor( node ) );
      // _.arrayAppendArray( dnode.originalOutNodes, group.nodeOutNodesFor( node ) );
    }
  }

}

// --
// etc
// --

function nodeNameFromGetterId( node )
{
  let group = this;
  return group.nodeToId( node );
}

//

function nodeNameFromFieldName( node )
{
  let group = this;
  return node.name;
}

//

function nodeIs_default( node )
{
  if( node === null || node === undefined )
  return false;
  return _.maybe;
}

//

function inNodesFromGroupCache( node )
{
  let group = this;
  let outNodes = group._inNodesCacheHash.get( node );
  _.assert( _.arrayIs( outNodes ), 'No cache for the node' );
  return outNodes;
}

//

function nodesFromFieldNodes( node )
{
  let group = this;
  return node.nodes;
}

//

function nodesFromFieldOutNodes( node )
{
  let group = this;
  return node.outNodes;
}

//

function nodesFromFieldInNodes( node )
{
  let group = this;
  return node.inNodes;
}

//

function nodesFromIdsFromFieldNodes( node )
{
  let group = this;
  return group.idsToNodes( node.nodes );
}

//

function nodesFromIdsFromFieldOutNodes( node )
{
  let group = this;
  return group.idsToNodes( node.outNodes );
}

//

function nodesFromIdsFromFieldInNodes( node )
{
  let group = this;
  return group.idsToNodes( node.inNodes );
}

//

function nodesIdsFromNodesFromFieldNodes( node )
{
  let group = this;
  return group.nodesToIds( node.nodes );
}

//

function nodesIdsFromNodesFromFieldOutNodes( node )
{
  let group = this;
  return group.nodesToIds( node.outNodes );
}

//

function nodesIdsFromNodesFromFieldInNodes( node )
{
  let group = this;
  return group.nodesToIds( node.inNodes );
}

//

function nodesIdsFromFieldNodes( node )
{
  let group = this;
  return node.nodes;
}

//

function nodesIdsFromFieldOutNodes( node )
{
  let group = this;
  return node.outNodes;
}

//

function nodesIdsFromFieldInNodes( node )
{
  let group = this;
  return node.inNodes;
}

// --
// relations
// --

let nodesSymbol = Symbol.for( 'nodes' );
let directSymbol = Symbol.for( 'direct' );

let Composes =
{
  direct : true,
}

let Aggregates =
{
  onNodeNameGet : nodeNameFromGetterId,
  onNodeQualifiedNameGet : null,
  onNodeEvaluate : null, /* qqq : cover by tests with different routines */
  onNodeIs : nodeIs_default,
  onOutNodesGet : nodesFromFieldNodes,
  onInNodesGet : null,
  onNodeInfoExport : null,
  onNodeIdGet : null,
}

let Associates =
{
  sys : null,
  nodes : _.define.own([]),
}

let Restricts =
{
  _inNodesCacheHash : null,
}

let Statics =
{

  ContainerIs,
  ContainerAdapterIs,
  ContainerMake,
  ContainerAdapterMake,
  ContainerAdapterFrom,

  ContainerAdapter,
  SetContainerAdapter,
  ArrayContainerAdapter,

}

let Forbids =
{
  onOutNodesIdsFor : 'onOutNodesIdsFor',
  onInNodesIdsFor : 'onInNodesIdsFor',
}

let Accessors =
{
  nodes : {},
  direct : {},
}

// --
// declare
// --

let Extend =
{

  init,
  finit,
  form,
  unform,
  clone,

  // reverse

  directSet,
  reverse,
  cacheInNodesFromOutNodesOnce,
  cacheInNodesFromOutNodesUpdate,
  cachesInvalidate,

  // export

  optionsExport,
  structureExport,
  infoExport,

  // descriptor

  nodeDescriptorWithId,
  nodeDescriptorWith,
  nodeDescriptorObtain,
  nodeDescriptorDelete,

  // node

  hasNode,
  hasNodes : vectorize( hasNode ),
  hasAllNodes : _.vectorizeAll( hasNode ),
  hasAnyNodes : _.vectorizeAny( hasNode ),
  hasNoneNodes : _.vectorizeNone( hasNode ),

  nodeIs,
  nodesAre : vectorize( nodeIs ),
  nodesAreAll : _.vectorizeAll( nodeIs ),
  nodesAreAny : _.vectorizeAny( nodeIs ),
  nodesAreNone : _.vectorizeNone( nodeIs ),

  nodeIndegree,
  nodesIndegree : vectorize( nodeIndegree ),
  nodeOutdegree,
  nodesOutdegree : vectorize( nodeOutdegree ),
  nodeDegree,
  nodesDegree : vectorize( nodeDegree ),
  nodeOutNodesFor,
  nodesOutNodesFor : vectorize( nodeOutNodesFor ),
  nodeInNodesFor,
  nodesInNodesFor : vectorize( nodeInNodesFor ),
  nodeOutNodesIdsFor,
  nodesOutNodesIdsFor : vectorize( nodeOutNodesIdsFor ),
  nodeInNodesIdsFor,
  nodesInNodesIdsFor : vectorize( nodeInNodesIdsFor ),
  nodeRefNumber,
  nodesSet,

  nodeAdd,
  nodesAdd : vectorize( nodeAdd ),
  nodeDelete,
  nodesDelete,

  nodeDataExport,
  nodesDataExport : vectorize( nodeDataExport ),
  nodeInfoExport,
  nodesInfoExport,
  nodesExportInfoTree,

  nodeToQualifiedName,
  nodesToQualifiedNames : vectorize( nodeToQualifiedName ),
  nodeToQualifiedNameTry,
  nodesToQualifiedNamesTry : vectorize( nodeToQualifiedNameTry ),
  nodeToName,
  nodesToNames : vectorize( nodeToName ),
  nodeToNameTry,
  nodesToNamesTry : vectorize( nodeToNameTry ),
  nodeToIdTry,
  nodesToIdsTry : vectorize( nodeToIdTry ),
  nodeToId,
  nodesToIds : vectorize( nodeToId ),
  idToNodeTry,
  idsToNodesTry : vectorize( idToNodeTry ),
  idToNode,
  idsToNodes : vectorize( idToNode ),
  idToName,
  idsToNames : vectorize( idToName ),

  // filter

  leastIndegreeAmong,
  mostIndegreeAmong,
  leastOutdegreeAmong,
  mostOutdegreeAmong,

  leastIndegreeOnlyAmong,
  mostIndegreeOnlyAmong,
  leastOutdegreeOnlyAmong,
  mostOutdegreeOnlyAmong,

  sourcesOnlyAmong,
  sinksOnlyAmong,

  // helper

  sourcesFromRoots,

  rootsAllReachable,
  rootsAll,
  nodesAs,
  nodesAsSet,
  nodesAsArray,
  nodesAsAdapter,

  ContainerIs,
  ContainerAdapterIs,
  OriginalOfAdapter,
  ContainerMake,
  ContainerAdapterMake,
  ContainerAdapterFrom,
  _routineArguments,

  // traverser

  lookBfs,
  lookDfs,
  lookDbfs,
  look : lookDfs,

  each,
  eachBfs,
  eachDfs,
  eachDbfs,

  // orderer

  dagTopSortDfs,
  dagTopSort : dagTopSortDfs,
  topSortSourceBasedBfs,
  topSortSourceBased : topSortSourceBasedBfs,
  topSortCycledSourceBasedBfs,
  topSortCycledSourceBased : topSortCycledSourceBasedBfs,

  // connectivity

  pairDirectedPathGetDfs,
  pairDirectedPathGet : pairDirectedPathGetDfs,
  pairDirectedPathExistsDfs,
  pairDirectedPathExists : pairDirectedPathExistsDfs,
  pairIsConnectedDfs,
  pairIsConnected : pairIsConnectedDfs,
  pairIsConnectedStronglyDfs,
  pairIsConnectedStrongly : pairIsConnectedStronglyDfs,

  nodesConnectedLayersDfs,
  nodesConnectedLayers : nodesConnectedLayersDfs,
  nodesStronglyConnectedLayersDfs,
  nodesStronglyConnectedLayers : nodesStronglyConnectedLayersDfs,
  nodesStronglyConnectedTreeDfs,
  nodesStronglyConnectedTree : nodesStronglyConnectedTreeDfs,

  // default

  nodeNameFromGetterId,
  nodeNameFromFieldName,
  nodeIs_default,
  inNodesFromGroupCache,

  nodesFromFieldNodes,
  nodesFromFieldOutNodes,
  nodesFromFieldInNodes,
  nodesFromIdsFromFieldNodes,
  nodesFromIdsFromFieldOutNodes,
  nodesFromIdsFromFieldInNodes,

  nodesIdsFromNodesFromFieldNodes,
  nodesIdsFromNodesFromFieldOutNodes,
  nodesIdsFromNodesFromFieldInNodes,
  nodesIdsFromFieldNodes,
  nodesIdsFromFieldOutNodes,
  nodesIdsFromFieldInNodes,

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
  extend : Extend,
});

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;
_.graph[ Self.shortName ] = Self;

})();
