{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

{-# OPTIONS_GHC -fno-warn-unused-binds   #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.ElastiCache.DescribeReplicationGroups
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- The /DescribeReplicationGroups/ action returns information about a
-- particular replication group. If no identifier is specified,
-- /DescribeReplicationGroups/ returns information about all replication
-- groups.
--
-- <http://docs.aws.amazon.com/AmazonElastiCache/latest/APIReference/API_DescribeReplicationGroups.html>
module Network.AWS.ElastiCache.DescribeReplicationGroups
    (
    -- * Request
      DescribeReplicationGroups
    -- ** Request constructor
    , describeReplicationGroups
    -- ** Request lenses
    , drgsMaxRecords
    , drgsMarker
    , drgsReplicationGroupId

    -- * Response
    , DescribeReplicationGroupsResponse
    -- ** Response constructor
    , describeReplicationGroupsResponse
    -- ** Response lenses
    , drgrMarker
    , drgrReplicationGroups
    , drgrStatus
    ) where

import           Network.AWS.ElastiCache.Types
import           Network.AWS.Pager
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | Represents the input of a /DescribeReplicationGroups/ action.
--
-- /See:/ 'describeReplicationGroups' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'drgsMaxRecords'
--
-- * 'drgsMarker'
--
-- * 'drgsReplicationGroupId'
data DescribeReplicationGroups = DescribeReplicationGroups'
    { _drgsMaxRecords         :: !(Maybe Int)
    , _drgsMarker             :: !(Maybe Text)
    , _drgsReplicationGroupId :: !(Maybe Text)
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'DescribeReplicationGroups' smart constructor.
describeReplicationGroups :: DescribeReplicationGroups
describeReplicationGroups =
    DescribeReplicationGroups'
    { _drgsMaxRecords = Nothing
    , _drgsMarker = Nothing
    , _drgsReplicationGroupId = Nothing
    }

-- | The maximum number of records to include in the response. If more
-- records exist than the specified @MaxRecords@ value, a marker is
-- included in the response so that the remaining results can be retrieved.
--
-- Default: 100
--
-- Constraints: minimum 20; maximum 100.
drgsMaxRecords :: Lens' DescribeReplicationGroups (Maybe Int)
drgsMaxRecords = lens _drgsMaxRecords (\ s a -> s{_drgsMaxRecords = a});

-- | An optional marker returned from a prior request. Use this marker for
-- pagination of results from this action. If this parameter is specified,
-- the response includes only records beyond the marker, up to the value
-- specified by /MaxRecords/.
drgsMarker :: Lens' DescribeReplicationGroups (Maybe Text)
drgsMarker = lens _drgsMarker (\ s a -> s{_drgsMarker = a});

-- | The identifier for the replication group to be described. This parameter
-- is not case sensitive.
--
-- If you do not specify this parameter, information about all replication
-- groups is returned.
drgsReplicationGroupId :: Lens' DescribeReplicationGroups (Maybe Text)
drgsReplicationGroupId = lens _drgsReplicationGroupId (\ s a -> s{_drgsReplicationGroupId = a});

instance AWSPager DescribeReplicationGroups where
        page rq rs
          | stop (rs ^. drgrMarker) = Nothing
          | stop (rs ^. drgrReplicationGroups) = Nothing
          | otherwise =
            Just $ rq & drgsMarker .~ rs ^. drgrMarker

instance AWSRequest DescribeReplicationGroups where
        type Sv DescribeReplicationGroups = ElastiCache
        type Rs DescribeReplicationGroups =
             DescribeReplicationGroupsResponse
        request = post
        response
          = receiveXMLWrapper "DescribeReplicationGroupsResult"
              (\ s h x ->
                 DescribeReplicationGroupsResponse' <$>
                   (x .@? "Marker") <*>
                     (x .@? "ReplicationGroups" .!@ mempty >>=
                        may (parseXMLList "ReplicationGroup"))
                     <*> (pure (fromEnum s)))

instance ToHeaders DescribeReplicationGroups where
        toHeaders = const mempty

instance ToPath DescribeReplicationGroups where
        toPath = const "/"

instance ToQuery DescribeReplicationGroups where
        toQuery DescribeReplicationGroups'{..}
          = mconcat
              ["Action" =:
                 ("DescribeReplicationGroups" :: ByteString),
               "Version" =: ("2015-02-02" :: ByteString),
               "MaxRecords" =: _drgsMaxRecords,
               "Marker" =: _drgsMarker,
               "ReplicationGroupId" =: _drgsReplicationGroupId]

-- | Represents the output of a /DescribeReplicationGroups/ action.
--
-- /See:/ 'describeReplicationGroupsResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'drgrMarker'
--
-- * 'drgrReplicationGroups'
--
-- * 'drgrStatus'
data DescribeReplicationGroupsResponse = DescribeReplicationGroupsResponse'
    { _drgrMarker            :: !(Maybe Text)
    , _drgrReplicationGroups :: !(Maybe [ReplicationGroup])
    , _drgrStatus            :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'DescribeReplicationGroupsResponse' smart constructor.
describeReplicationGroupsResponse :: Int -> DescribeReplicationGroupsResponse
describeReplicationGroupsResponse pStatus =
    DescribeReplicationGroupsResponse'
    { _drgrMarker = Nothing
    , _drgrReplicationGroups = Nothing
    , _drgrStatus = pStatus
    }

-- | Provides an identifier to allow retrieval of paginated results.
drgrMarker :: Lens' DescribeReplicationGroupsResponse (Maybe Text)
drgrMarker = lens _drgrMarker (\ s a -> s{_drgrMarker = a});

-- | A list of replication groups. Each item in the list contains detailed
-- information about one replication group.
drgrReplicationGroups :: Lens' DescribeReplicationGroupsResponse [ReplicationGroup]
drgrReplicationGroups = lens _drgrReplicationGroups (\ s a -> s{_drgrReplicationGroups = a}) . _Default;

-- | FIXME: Undocumented member.
drgrStatus :: Lens' DescribeReplicationGroupsResponse Int
drgrStatus = lens _drgrStatus (\ s a -> s{_drgrStatus = a});
