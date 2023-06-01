.. include:: /_styles/text_roles.rst
.. include:: /_styles/substitutions.rst
.. sectnum::
   :suffix: .
   :start: 1

.. _lab_env:

Explore the Course Lab Environment
==================================

Before diving into OpenStack and its components, take some time to explore the classroom environment. Understanding how things are currently configured will be beneficial for your learning as you move forward in the class.

By the end of this exercise, you should be able to:

- Understand and explore the currently configured environment to help with the execution of the remaining lab exercises
- Run the Devstack script to configure your VM network interface properties (ip address) to the OpenStack components installed

Strigo Lab Environment:
-----------------------

Your lab environment is running as a virtual machine (VM) instance in AWS. You use **Strigo** to access and manage the lab environment.

Your virtual machine is provisioned and started when you connect to a Strigo event.


Class Notes:
------------

For steps using the Dashboard UI, you need to use Mozilla Firefox or Google Chrome, with the *Dynamic DNS address*.

All students have their own Strigo VM to perform lab exercise steps independently.

To determine the Strigo VM's IP addresses and Dynamic DNS address for your environment take the following steps:

:step:`Step 1:` In the **Strigo vlab** environment, click the **Lab Settings** (gear) icon. 

:step:`Step 2:` Click Machine Info to display a pop-up similar to the following: 

.. image:: /images/Strigo_machine_info.png


This will be where you get the **Public** and **Private** IP addresses for your VM, as well as the **Dynamic DNS address**. You use the **Dynamic DNS address** for accessing remote, such as the OpenStack Dashboard UI. The **Private IP** is used by Devstack for OpenStack process communication. 


For Linux command line:
-----------------------

In some exercise steps, you use the Linux CLI. This is your **Strigo vlab** environment. You are automatically connected to it without the need for an SSH connection.

You may have multiple terminal CLI sessions to your Strigo vlab environment. By default you will have an initial CLI session logged in as the ``ubuntu`` user.

To create a separate terminal session, select the ``+`` next to the session tab. This new session will also be logged in as the user  ``ubuntu``.


Users and Passwords
-------------------

In various lab steps of this guide you will need to specify the user name and the password to log in. Where applicable, this guide will remind you of which credentials to use.

Below is a summary of the user names and passwords used in the environment:

+-----------+-------------+------------------------------------------+
| User Name |	Password  |	Description                              |
+===========+=============+==========================================+
| stack	    | b00tcamp	  | Linux CLI user                           |
+-----------+-------------+------------------------------------------+
| demo	    | nova  	  | OpenStack user with Member privileges    |
+-----------+-------------+------------------------------------------+
| admin	    | nova  	  | OpenStack user with admin privileges     |
+-----------+-------------+------------------------------------------+
| cirros	| gocubsgo	  | User for instances based on CirrOS image |
+-----------+-------------+------------------------------------------+

Deploy Devstack Components
--------------------------

In this exercise you will deploy the Devstack configuration with the Strigo VM's ENS-enabled AWS network interface.

:step:`Step 1:` Access the Linux CLI environment, the **Strigo vlab** environment in the right pane.

:step:`Step 2:`  Switch from the ``ubuntu`` user to the ``stack`` user: 

.. code-block:: console

    [ubuntu@vlab ~] $ sudo su - stack

.. code-block:: console
    
    [ubuntu@vlab ~] $ cd ~/devstack

.. code-block:: console
    
    [ubuntu@vlab ~] $ pwd
    /opt/stack/devstack

:step:`Step 3:` Run the devstack script. This will verify components and apply the local.conf changes to all of the OpenStack components installed:

Note: this script will run approx. 15-30 min, please let the process complete without any other interaction to the Strigo VM before moving to the next step.

.. code-block:: console
    
    [ubuntu@vlab ~] $ ./stack.sh

    (Partial output)
    ...
    =========================
    DevStack Component Timing
    (times are in seconds)
    =========================
    run_process           27
    test_with_retry        3
    osc                  348
    wait_for_service      18
    dbsync                44
    -------------------------
    Unaccounted time     344
    =========================
    Total runtime        784
    This is your host IP address: 172.xx.xx.xx
    Horizon is now available at http://172.xx.xx.xx/dashboard (The Dynamic DNS name should be used in place of the 172.xx.xx.x for labs.)
    Keystone is serving at http://172.xx.xx.xx/identity/
    The default users are: admin and demo
    The password: OpenInfra
    ...
    DevStack Version: zed
    Change: c6f810e61d51fe07b483693a2d6f95eb5546a9ed Merge "Move process-stackviz role from Tempest
    to Devstack" into    stable/zed 2022-08-18 15:45:04 +0000
    OS Version: Ubuntu 20.04 focal

:step:`Step 4:` We now need to allow time for all the OpenStack components to finish their processing from the previous step's script completion. After watching the process for a minute or two we will return to our discussion and other deployment options available to us.


Conclusion
----------
Great job, you are done with the Deploying Development OpenStack chapter.

Summary

In this lab, you:

Connected to the Strigo vlab environment
Ran a script to configure the OpenStack components with the Private IP address using our default local.conf configuration file