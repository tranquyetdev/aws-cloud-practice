import * as core from '@actions/core';
import isCI from 'is-ci';
import { getAffectedBuild } from './nx';
import { IDeployMatrix, getDeployConfig } from './deploy';

export const setOutput = (name: string, value: any) => {
  const skip = [
    {
      name: 'SKIP',
      shortName: 'SKIP',
      run: false,
    },
  ];

  const matrix =
    (Array.isArray(value) || typeof value === 'string') && value.length === 0
      ? skip
      : value;

  const output = Array.isArray(value)
    ? isCI
      ? JSON.stringify({ include: matrix })
      : JSON.stringify({ include: matrix }, null, 2)
    : value;

  // eslint-disable-next-line
  console.log(`matrix ${name} = ${output}`);

  if (isCI) {
    core.setOutput(`${name}`, `${output}`);
  } else {
    // eslint-disable-next-line
    console.log(`${name}=${output}`);
  }
};

(function setMatrix() {
  console.log('setMatrix...');

  const allMatrix: IDeployMatrix = {
    ecsMatrix: {
      include: [],
    },
    cloudfrontMatrix: {
      include: [],
    },
  };

  const affectedBuildProjects = getAffectedBuild();

  console.log(`affectedBuildProjects`, affectedBuildProjects);

  affectedBuildProjects.forEach((project) => {
    const { matrix, projectId } = getDeployConfig(project);

    if (matrix.ecsMatrix) {
      allMatrix.ecsMatrix.include.push({
        run: true,
        name: projectId,
      });
    }

    if (matrix.cloudfrontMatrix) {
      allMatrix.cloudfrontMatrix.include.push({
        run: true,
        name: projectId,
      });
    }
  });

  console.log(`ecsMatrix`, allMatrix.ecsMatrix);
  console.log(`cloudfrontMatrix`, allMatrix.cloudfrontMatrix);

  setOutput('ecsMatrix', allMatrix.ecsMatrix);
  setOutput('cloudfrontMatrix', allMatrix.cloudfrontMatrix);
})();