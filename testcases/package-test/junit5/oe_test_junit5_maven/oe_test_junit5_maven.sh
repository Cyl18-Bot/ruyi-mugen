#!/usr/bin/bash

# Copyright (c) 2021. Huawei Technologies Co.,Ltd.ALL rights reserved.
# This program is licensed under Mulan PSL v2.
# You can use it according to the terms and conditions of the Mulan PSL v2.
#          http://license.coscl.org.cn/MulanPSL2
# THIS PROGRAM IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
# EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
# MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
# See the Mulan PSL v2 for more details.

# #############################################
# @Author    :   huyahui
# @Contact   :   huyahui8@163.com
# @Date      :   2020/5/16
# @License   :   Mulan PSL v2
# @Desc      :   Run junit5 in maven
# #############################################

source "../common/lib.sh"

function pre_test() {
    LOG_INFO "Start environment preparation."
    pre_junit5
    pre_maven
    LOG_INFO "End of environmental preparation!"
}

function run_test() {
    LOG_INFO "Start testing..."
    mvn -version
    CHECK_RESULT $?
    mkdir -p junit5-maven/src/main/java/com/example/junit5/
    mkdir -p junit5-maven/src/test/java/com/example/junit5/
    cp pom.xml junit5-maven
    cp TestJunit5.java junit5-maven/src/test/java/com/example/junit5/
    cd junit5-maven || exit 1
    mvn test >result
    CHECK_RESULT $?
    grep 'Tests run: 2, Failures: 0, Errors: 0, Skipped: 0' result
    CHECK_RESULT $?
    grep 'BUILD SUCCESS' result
    CHECK_RESULT $?
    cd - || exit 1
    LOG_INFO "Finish test!"
}

function post_test() {
    LOG_INFO "start environment cleanup."
    clean_junit5
    clean_maven
    rm -rf junit5-maven
    LOG_INFO "Finish environment cleanup!"
}
main "$@"
