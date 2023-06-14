Redeploy OpenStack with additional Heat services
================================================

Now that we have the foundation of an OpenStack deployment, we will explore the following topics:

- Unstacking the environment resetting all services
- Editing the local.conf file used by Devstack during deployment
- Deploying OpenStack again with additional components and configuration.
- Login to the OpenStack UI again to verify new Heat components are present

Unstack OpenStack deployment
----------------------------

In this exercise, you use the CLI to tear down the OpenStack deployment created previously to ready it for redeployment with additional **Heat** services.

:step:`Step 1:` Access your Linux CLI (Strigo vlab) environment. Make sure you are the ``stack`` user and are in the ``/opt/stack/devstack`` working directory. 

.. code-block:: console
    
    [ubuntu@vlab ~] $ whoami
    stack

.. code-block:: console

    [ubuntu@vlab ~] $ pwd
    /opt/stack/devstack

:step:`Step 2:` Run the ``unstack.sh`` script located in the ``/opt/stack/devstack`` directory

.. code-block:: console

    [ubuntu@vlab ~] $ ./unstack.sh

Note: This command could take a few minutes to complete. Please wait for it to finish before moving on to the next task.


Edit the local.conf file to change deployment options 
-----------------------------------------------------

Using the editor of your choice, edit the ``local.conf`` file used by Devstack during deployment. In this step we enable the ``Heat`` and ``Heat Dashboard`` services to allow local heat orchestration options in our OpenStack deployment.

.. code-block:: console

    [ubuntu@vlab ~] $ vim /opt/stack/devstack/local.conf

Scroll down in the file and remove the comments (Hash marks on the beginning of the line) from the 2 Heat services as shown here:

.. image:: /images/local.conf_remove_comments.png

Save the file and exit.

Next let's add some additional service definitions to our config. These instructions tell the glance service to ``show multiple locations`` after the glance service has been deployed. This is done at the bottom of the configuration file in the post-build section. The second post-config option we have chosen is a Horizon setting to allow glance locations with the URL option. Since each service is rebuilt when we restack our configuration, the changes must be made in this file and ingested by the Devstack installer and applied once th service is installed again. Add the following lines to the bottom of the ``local.conf`` file:

.. code-block:: console

    [[post-config|$GLANCE_API_CONF]]
    [DEFAULT]
    show_multiple_locations = true

    [[post-config|$HORIZON_CONF]]
    [DEFAULT]
    IMAGES_ALLOW_LOCATION = True


Deploy OpenStack with the additional Heat services and post-config
------------------------------------------------------------------

Now that we have edited the main configuration file for devstack located at ``/opt/stack/devstack/local.conf``, you are now ready to deploy OpenStack once more with the additional services we enabled in the previous step.

:step:`Step 1:` Run the devstack script. This will verify components and apply the local.conf changes to all of the OpenStack components installed:

Note: this script will run approx. 15-30 min, please let the process complete without any other interaction to the Strigo VM before moving to the next step.

.. code-block:: console

    [ubuntu@vlab ~] $ time ./stack.sh

Once the deployment is finished you can log back in to the UI and confirm that the Heat orchestration components have been installed.


Verify new components have been installed and are functional
------------------------------------------------------------

In this Exercise, you login to the Dashboard UI and verify that Heat is now deployed.

:step:`Step 1:` Log in to the Dashboard UI as **admin / nova**.

Make sure the project is **demo**.

.. image:: /images/heat-change-project.png

:step:`Step 2:` Navigate to the Stacks page (**Project > Orchestration > Stacks**). No stacks should be running.



This is the Heat Orchestration dashboard you would use to deploy Heat stacks to your local OpenStack deployment for testing and evaluation. Your heat templates can be analyzed and perfected in the local environment without disrupting production systems or using production resources. This is only one example of how OpenStack deployments can be tested locally or using a single cloud node to perform testing and evaluation. This is also a good way to learn about the differences between releases and prepare for the upgrade of your own production systems, preventing downtime and making upgrades go smoother once challenges are understood and a plan for migration has been made.


Conclusion
----------

Localized testing and development work can be an excellent way to get work done more quickly and make assurances that production systems experience minimal downtime during upgrades to both code components as well as infrastructure. In this section we added Heat components. Heat is a great orchestration (automation) tool to quickly spin up multiple resources and their dependencies. It is only a matter of creating and debugging yaml templates to have a reliable and reproducible environment. 


Huzzah! You have completed the Redeploy OpenStack with additional services lab.

In this lab, you:

- Unstacked and removed all OpenStack services
- Edited the devstack configuration file and added 2 more services
- Added post-config options to alter service behavior
- Logged into the Dashboard UI to verify the new Orchestration section is present.