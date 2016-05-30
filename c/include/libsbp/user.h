/*
 * Copyright (C) 2015 Swift Navigation Inc.
 * Contact: Fergus Noble <fergus@swift-nav.com>
 *
 * This source is subject to the license found in the file 'LICENSE' which must
 * be be distributed together with this source. All other rights reserved.
 *
 * THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,
 * EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
 */

/*****************************************************************************
 * Automatically generated from yaml/swiftnav/sbp/user.yaml
 * with generate.py. Please do not hand edit!
 *****************************************************************************/

/** \defgroup user User
 *
 *  * Messages reserved for use by the user.
 * \{ */

#ifndef LIBSBP_USER_MESSAGES_H
#define LIBSBP_USER_MESSAGES_H

#include "common.h"


/** User data
 *
 * This message can contain any application specific user data up to a
 * maximum length of 255 bytes per message.
 */
#define SBP_MSG_USER_DATA 0x0800
typedef struct __attribute__((packed)) {
  u8 contents[0]; /**< User data payload */
} msg_user_data_t;


/** User cmd with data
 *
 * This message is used for user specific rpc.
 */
#define SBP_MSG_USER_CMD  0x0801
typedef struct __attribute__((packed)) {
  u8 cmd;     /**< command byte */
  u8 data;    /**< data byte */
} msg_user_cmd_t;


/** User PWM data
 *
 * This message contain 4 pwm channels in percent.
 */
#define SBP_MSG_USER_PWM  0x0802
typedef struct __attribute__((packed)) {
  u8 pwm0;    /**< pwm raw 0 */
  u8 pwm1;    /**< pwm raw 1 */
  u8 pwm2;    /**< pwm raw 2 */
  u8 pwm3;    /**< pwm raw 3 */
} msg_user_pwm_t;


/** \} */

#endif /* LIBSBP_USER_MESSAGES_H */