#!/usr/bin/env sh
@{
import os
}@

# fail script if any single command fails
set -e

echo "Doc job: @doc_job_name"
echo ""

# consider CCACHE_DIR from environment, otherwise set to default
CCACHE_DIR=${CCACHE_DIR:-~/.ccache}

export WORKSPACE=`pwd`
echo "Use workspace: $WORKSPACE"
echo ""

@(TEMPLATE(
    'devel/devel_script_check.sh.em',
))@

echo ""
@[if os.environ.get('TRAVIS') == 'true']@
echo "travis_fold:start:doc-clone-source-repos"
@[end if]@
echo "Clone source repositories"
echo ""

@(TEMPLATE(
    'devel/devel_script_clone.sh.em',
    workspace_path='catkin_workspace',
    scms=scms,
))@
@[if os.environ.get('TRAVIS') == 'true']@
echo "travis_fold:end:doc-clone-source-repos"
@[end if]@

echo ""
@[if os.environ.get('TRAVIS') == 'true']@
echo "travis_fold:start:doc-build-workspace"
@[end if]@
echo "Build workspace"
echo ""

@(TEMPLATE(
    'devel/devel_script_build.sh.em',
    scripts=scripts,
))@
@[if os.environ.get('TRAVIS') == 'true']@
echo "travis_fold:end:doc-build-workspace"
@[end if]@

echo ""
echo "Generated documentation: $WORKSPACE/generated_documentation/api_rosdoc"
echo ""
