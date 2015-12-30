#!/bin/bash

#这样也可以进行调试的哈，但不好使。。。
#!/bin/bash -xv

for i in {1..10};
do
    #此处可以设置 只针对这部分脚本进行调试  set -x   set +x
#    set -x
    echo -n $i;
#    set +x
done

