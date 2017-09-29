//
//  mp4v2.h
//  mp4v2
//
//  Created by Maxime CHAPELET on 08/09/2017.
//
//

#import <Foundation/Foundation.h>

#ifndef MP4V2_MP4V2_H
#define MP4V2_MP4V2_H

/*****************************************************************************/

#include "platform.h"

/*****************************************************************************/

/* exploit C++ ability of default values for function parameters */
#if defined( DEFAULT )
#   define __MP4V2_SAVE_DEFAULT DEFAULT
#endif
#undef DEFAULT
#if defined( __cplusplus )
#   define DEFAULT(x) =x
#else
#   define DEFAULT(x)
#endif

#ifdef __cplusplus
extern "C" {
#endif
  
  /*****************************************************************************/
  
#include "general.h"
#include "file.h"
#include "file_prop.h"
#include "track.h"
#include "track_prop.h"
#include "sample.h"
#include "chapter.h"
#include "itmf_generic.h"
#include "itmf_tags.h"
#include "streaming.h"
#include "isma.h"
  
  /*****************************************************************************/
  
  /* restore macro DEFAULT to state prior to mp4v2 headers */
#undef DEFAULT
#if defined( __MP4V2_SAVE_DEFAULT )
#   define DEFAULT __MP4V2_SAVE_DEFAULT
#endif
  
#ifdef __cplusplus
} // extern "C"
#endif

/*****************************************************************************/

#endif /* MP4V2_MP4V2_H */

//! Project version number for mp4v2.
FOUNDATION_EXPORT double mp4v2VersionNumber;

//! Project version string for mp4v2.
FOUNDATION_EXPORT const unsigned char mp4v2VersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <mp4v2/PublicHeader.h>


