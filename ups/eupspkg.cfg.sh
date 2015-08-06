# EupsPkg config file. Sourced by 'eupspkg'

if [ -n "${PBS_DIR:+x}" ]; then
    pbs_options+=" --with-pbs-include=$PBS_DIR/include --with-pbs-lib=$PBS_DIR/lib"
    LD_LIBRARY_PATH+=":$PBS_DIR/lib"
else
    if [ -n "${PBS_INCLUDE_DIR:+x}" ]; then
        pbs_options+=" --with-pbs-include=$PBS_INCLUDE_DIR"
    fi
    if [ -n "${PBS_LIB_DIR:+x}" ]; then
        pbs_options+=" --with-pbs-lib=$PBS_LIB_DIR"
        LD_LIBRARY_PATH+=":$PBS_LIB_DIR"
    fi
fi

CONFIGURE_OPTIONS="--prefix=$PREFIX --enable-shared --disable-fortran $pbs_options"
