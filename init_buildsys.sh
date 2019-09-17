#!/bin/bash
ed -s $ANDROID_BUILD_TOP/build/make/target/product/base_system.mk <<EOF
/^$
i

PRODUCT_PACKAGES += spihello
.
w
EOF
