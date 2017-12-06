# TODO(nuclearsandwich) This is very a hack to install a modified copy of catkin-pkg. It's fine for now.
RUN git clone https://github.com/ros-infrastructure/catkin_pkg -b @(branch_name) /tmp/catkin-pkg
RUN cd /tmp/catkin-pkg && python3 setup.py install

