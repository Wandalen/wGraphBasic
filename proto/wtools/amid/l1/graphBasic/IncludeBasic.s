( function _UseAbstractBase_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  const _ = require( '../../../../node_modules/Tools' );

  _.include( 'wProto' );
  _.include( 'wCopyable' );

}

//

/**
 * @summary Collection of abstract data structures and algorithms to process graphs.
 * @namespace wTools.graph
 * @module Tools/mid/AbstractGraphs
*/

const _ = _global_.wTools;
const Parent = null;
const Self = _.graph = _.graph || Object.create( null );

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
